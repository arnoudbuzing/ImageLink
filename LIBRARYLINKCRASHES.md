# LibraryLink Kernel Crashes — Root Cause & Mitigations

> **Project:** ImageLink  
> **Date:** 2026-04-29  
> **Symptom:** Wolfram Kernel killed (exit 137 / `signal: killed`) immediately on `LibraryFunctionLoad` or `Needs["ArnoudBuzing\`ImageLink\`"]`  
> **Root cause:** `inventory` crate stack overflow during `__mod_init_func` initialisation  

---

## 1. Background: How `wolfram-library-link` Registers Exported Functions

The Rust crate `wolfram-library-link` (v0.2.x) uses the `#[export]` proc-macro to expose
Rust functions to the Wolfram Kernel via LibraryLink. Under the hood, each `#[export]`
annotation generates two things:

1. A public C-ABI wrapper function (e.g. `_get_version`, `_resize_image`, …) that
   translates LibraryLink `MArgument` pointers into Rust types and back.
2. An **`inventory::submit!`** call that registers a `LibraryLinkFunction` descriptor
   (name, type signature, function pointer) into a global, distributed registry.

The `inventory` crate (used via `wolfram-library-link`) implements its registry using a
**singly-linked list built entirely at dylib load time**, before `main()` / the Wolfram
Kernel ever calls a single exported function. The mechanism looks like this:

```
inventory::collect!(LibraryLinkFunction);   // in wolfram-library-link itself
inventory::submit! { LibraryLinkFunction { … } }  // one per #[export] function
```

On **macOS**, Rust (and C/C++) static initialisers run inside the
`__DATA_CONST, __mod_init_func` section. The dynamic linker (`dyld`) calls each
function pointer in that section **sequentially on the thread that calls `dlopen()`**
before `dlopen()` returns. There is no concurrency; they run on the caller's stack.

Each `inventory::submit!` generates one entry in `__mod_init_func`. The init function
for entry *N* prepends a new node to a global linked list and then calls the init
function for entry *N-1* **recursively** (this is how inventory v0.2.x chains its
nodes). With a large number of exports the recursion depth becomes:

```
depth ≈ number of #[export] functions
```

---

## 2. The Threshold That Causes the Crash

We observed the following during development:

| `#[export]` count in `librust.dylib` | Result |
|---|---|
| ≤ 36 (committed HEAD, Batch 0) | ✅ loads cleanly |
| ~37–40 (Batch 1 additions) | ✅ still loads |
| ~41–44 (Batch 2 additions in same dylib) | 💥 exit 137 (SIGKILL) |

The exact threshold depends on the default **thread stack size** of the Wolfram Kernel
subprocess that calls `dlopen`. On macOS ARM64 the default stack is 512 KB for the main
thread of a subprocess, which is exhausted at around 40–45 levels of `__mod_init_func`
recursion when each frame also carries the relatively large Rust function frames involved
in the inventory linked-list prepend.

### Why SIGKILL and not SIGSEGV?

macOS uses a dedicated **guard page** below the stack. When the stack overflows into the
guard page the kernel delivers `SIGSEGV`. However, the Wolfram Kernel child process that
handles LibraryLink loading has an additional **resource limit** (likely `RLIMIT_AS` or
an internal watchdog) that fires first and sends `SIGKILL` (signal 9), producing exit
code 137. This is why:

- `RUST_BACKTRACE=1` produces no output — the process is killed before the Rust panic
  handler can run.
- The `dlopen()` call in a plain C test program also returns exit 137 with no error
  message.
- The crash appears instantaneous and always at `LibraryFunctionLoad` time, never
  mid-execution.

---

## 3. What We Tried That Did NOT Work

### 3.1 `strip -x`

Running `strip -x target/release/librust.dylib` reduces the binary size from ~6.9 MB to
~5.9 MB, but it strips **local symbols** that `inventory`'s linked-list nodes use at
init time. After stripping, `get_version` could no longer be found and the kernel
produced a different error. **Do not strip this dylib with `-x`.**

### 3.2 Replacing `#[export]` with `extern "C"` for Batch 2

We attempted to define the four Batch 2 functions using plain `extern "C"` instead of
`#[export]`, bypassing `inventory`. This compiles but the Wolfram Kernel cannot auto-
discover these functions without the `LibraryLinkFunction` metadata that `#[export]`
generates. The functions themselves load correctly via `LibraryFunctionLoad`, but the
approach still crashes if the dylib has **too many** `#[export]`s for other functions,
because the inventory init chain still runs for those.

### 3.3 Commenting Out Batch 2 Loads in `ImageLink.wl`

Commenting out the `LibraryFunctionLoad` calls in the Wolfram Language layer does **not**
help. The crash happens during `dlopen` of the `.dylib` before any WL code runs —
the `__mod_init_func` chain fires unconditionally whenever the library is loaded into
the process.

### 3.4 Adding `panic::catch_unwind`

Not applicable here — the crash is a stack overflow / OOM kill, not a Rust panic. Rust
panics propagating across FFI boundaries are a separate (and also real) concern, but not
the cause of this specific issue.

---

## 4. The Fix: Split into Multiple Smaller Dylibs

The root cause is a single dylib accumulating too many `#[export]` registrations. The
solution is **one cdylib crate per functional batch**, each staying well under ~35
exported functions.

### Current Architecture

```
ImageLink/
├── rust/                  ← Batch 0 + Batch 1  (~36 #[export])
│   └── → librust.dylib
├── rust_stats/            ← Batch 2 Analysis  (5 #[export])
│   └── → librust_stats.dylib
└── ImageLink/
    └── LibraryResources/
        └── MacOSX-ARM64/
            ├── librust.dylib
            └── librust_stats.dylib
```

In `ImageLink.wl`:

```wolfram
$LibraryFile      = FileNameJoin[{DirectoryName[$InputFileName], "LibraryResources",
                     $SystemID, "librust.dylib"}];
$LibraryFileStats = FileNameJoin[{DirectoryName[$InputFileName], "LibraryResources",
                     $SystemID, "librust_stats.dylib"}];
```

Each batch of new functions gets its own crate and dylib. The Wolfram Language layer
simply loads functions from whichever dylib they live in.

---

## 5. Rules for Adding Future Functions

1. **Count before you commit.** Before adding new `#[export]` functions to an existing
   crate, run:
   ```bash
   grep -c "#\[export\]" rust/src/lib.rs
   ```
   Keep the count at **≤ 35** per dylib to leave headroom.

2. **Never exceed 35 `#[export]` per dylib.** When a crate approaches this limit, create
   a new sibling crate (e.g. `rust_geometry/`, `rust_morphology/`) with its own
   `Cargo.toml` and copy `.cargo/config.toml` from `rust/`.

3. **Do not use `strip -x`** on any dylib produced by this project. It removes symbols
   needed by `inventory` at runtime.

4. **Each new crate needs `.cargo/config.toml`** pointing to the Wolfram Engine
   installation so that `wstp-sys` can find its compiler additions:
   ```toml
   [env]
   WOLFRAM_APP_DIRECTORY  = { value = "../wolfram", relative = true }
   WSTP_COMPILER_ADDITIONS = { value = "../wolfram/WSTP/DeveloperKit/MacOSX-ARM64/CompilerAdditions", relative = true }
   ```

5. **Test the dylib loads in isolation** before integrating into `ImageLink.wl`. Use the
   minimal script pattern:
   ```wolfram
   f = LibraryFunctionLoad["/path/to/librust_new.dylib", "get_version", {}, "UTF8String"];
   Print[f[]]
   ```
   If the kernel is killed, the new dylib has too many `#[export]`s or a static init panic.

---

## 6. Longer-Term Alternatives

If the number of total functions grows very large, consider one of these architectural
alternatives:

### 6.1 Upgrade `inventory` / `wolfram-library-link`

The `inventory` crate v0.3.x rewrote its implementation to use **linker sections** rather
than recursive `__mod_init_func` calls on some platforms. Upgrading
`wolfram-library-link` to a version that uses `inventory` ≥ 0.3 may eliminate this
problem entirely. Check the `wolfram-library-link` changelog before upgrading.

### 6.2 Manual Function Table (no `#[export]`)

Replace `#[export]` with a **hand-rolled** function table — a static array of
`(name, fn_ptr)` pairs — and write a single `WolframLibrary_initialize` function that
registers them all. This is more verbose but gives complete control:

```rust
#[no_mangle]
pub extern "C" fn WolframLibrary_initialize(lib_data: WolframLibraryData) -> c_int {
    // register all functions manually
    0
}
```

### 6.3 Lazy Loading in Wolfram Language

Load each dylib with `LibraryFunctionLoad` only when the corresponding high-level
function is first called (using `Once` or `OnceFunctionLoad` patterns in WL). This does
not reduce the per-dylib `#[export]` count but avoids loading all dylibs at package
initialisation time, improving startup latency.

---

## 7. Diagnostic Checklist

When the kernel is killed on library load:

| Check | Command |
|---|---|
| How many `#[export]` in the crate? | `grep -c "#\[export\]" rust/src/lib.rs` |
| Does the dylib load standalone? | See §5 test pattern |
| Is the dylib stripped? | `nm -U librust.dylib \| grep get_version` — should show `T _get_version` |
| Are `__mod_init_func` entries present? | `otool -l librust.dylib \| grep -A3 mod_init_func` |
| How many init functions? | Count entries × 8 bytes from `size` field above |
| Any obvious panic in Rust? | `RUST_BACKTRACE=1 /tmp/test_dylib` (won't help if OOM-killed) |

---

## 8. Summary

> **TL;DR:** Each `#[export]` in a `wolfram-library-link` Rust cdylib adds one recursive
> `__mod_init_func` call via the `inventory` crate. On macOS ARM64, the Wolfram Kernel
> subprocess stack is exhausted at roughly 40 such calls, causing an immediate `SIGKILL`
> (exit 137) with no diagnostic output. **Fix:** keep ≤ 35 `#[export]` per dylib and
> split additional functions into separate sibling crates.
