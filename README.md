# WSTP Linker Issue Resolution (Windows MSVC)

This document details the resolution of a common but complex linker error encountered when building Rust libraries that link against the Wolfram Symbolic Transfer Protocol (WSTP) on Windows.

## The Problem

When attempting to build the Rust project using `cargo build --release`, the linker failed with the following error:

```text
libwstp_sys.rlib(mlgreet.obj) : error LNK2019: unresolved external symbol __std_find_trivial_1 referenced in function ...
C:\...\rust.dll : fatal error LNK1120: 1 unresolved externals
```

Additionally, warnings about conflicting default libraries were observed:
```text
LINK : warning LNK4098: defaultlib 'LIBCMT' conflicts with use of other libs; use /NODEFAULTLIB:library
libcpmt.lib(xwctomb.obj) : error LNK2005: _Getcvt already defined in msvcprt.lib(MSVCP140.dll)
```

## Root Cause Analysis

### 1. STL Symbol Mismatch (`__std_find_trivial_1`)
The symbol `__std_find_trivial_1` is an internal optimization used by the Microsoft C++ Standard Library (STL) for algorithm functions like `std::find`. This symbol was introduced/modified in recent versions of Visual Studio 2022.

The error occurs because:
*   The **Static WSTP Library** (`wstp64i4s.lib`) provided by Wolfram was compiled with a version of MSVC that expects this symbol to be provided by the C++ runtime.
*   The **Local Build Environment** was either using a slightly different version of the MSVC toolset or was failing to link the correct runtime library that contains this specific symbol.

### 2. Runtime Conflict (Static vs. Dynamic)
*   `wstp64i4s.lib` is a **static** library. Linking against it often pulls in dependencies on the static C Runtime (`LIBCMT`) and static C++ Runtime (`LIBCPMT`).
*   Rust `cdylib` projects on Windows typically prefer the dynamic C Runtime (`MSVCRT`) and dynamic C++ Runtime (`MSVCPRT`).
*   Mixing these two results in "already defined" symbols and missing internal STL symbols.

## The Solution: Forced Dynamic Linking

To resolve these conflicts and ensure a successful build, we shifted from linking against the static WSTP library to the **dynamic WSTP library**.

### 1. Environment Configuration
We updated `.cargo/config.toml` to point to the local WSTP files and explicitly requested dynamic linking:

```toml
[env]
WSTP_COMPILER_ADDITIONS = { value = "../wolfram/WSTP/DeveloperKit/Windows-x86-64/CompilerAdditions", relative = true }
WSTP_STATIC = "0"
```

### 2. Bypassing Build Script Restrictions
The `wstp-sys` crate (v0.2.8) on Windows has a build script that specifically searches for `wstp64i4s.lib` (the static lib) even when dynamic linking is requested. If it doesn't find it, it may panic or fail to resolve paths correctly.

**The Fix:**
1.  We identified the **Import Library** for the DLL: `wstp64i4.lib`.
2.  We created a copy of `wstp64i4.lib` and named it `wstp64i4s.lib` within the project's `CompilerAdditions` directory.
3.  This "tricks" the build script into finding the file it expects, but the linker actually uses the import library for the DLL.

### 3. Benefits of this approach
*   **No STL Conflicts**: Since we are linking against the DLL's import library, the problematic STL symbols are resolved at runtime by the Wolfram-provided DLL (`wstp64i4.dll`), which is guaranteed to be compatible with itself.
*   **Clean Runtime**: Avoids the conflict between `LIBCMT` and `MSVCRT`.
*   **Portability**: As long as the target system has Wolfram installed (and thus has `wstp64i4.dll` in the path), the library will load correctly.

## Verification
The solution was verified by running a Wolfram Language script that successfully loaded the resulting `librust.dll` and called its functions, returning the expected results without any runtime linking errors.
