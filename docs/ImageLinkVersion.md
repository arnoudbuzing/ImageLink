# ImageLinkVersion

`ImageLinkVersion[]` returns the version string of the underlying Rust library used by ImageLink.

## Usage

```wolfram
ImageLinkVersion[]
```

## Description

This function provides the version information of the Rust components. It is useful for debugging and ensuring that the correct binary resources are being loaded by the Wolfram Language paclet.

## Examples

### Get Version Information

```wolfram
ImageLinkVersion[]
(* "1.0.0" *)
```

## See Also

* [ImageLink.wl](../ImageLink/ImageLink.wl): The main Wolfram Language implementation file.
