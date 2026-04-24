# ImageLink

ImageLink is a high-performance paclet for the Wolfram Language that bridges the Rust `image` crate with the Wolfram Kernel via LibraryLink. It provides a suite of extremely fast image processing functions.

There are two sets of APIs available:
1. **File-Based Processing:** Directly processes images from disk to disk.
2. **In-Memory Processing:** Processes Wolfram `Image` objects natively in memory using zero-disk `NumericArray` operations.

## Loading the Paclet

Before using the functions, make sure to load the paclet:

```mathematica
PacletDirectoryLoad["/path/to/ImageLink"];
Needs["ImageLink`"];
```

---

## 1. In-Memory Processing (Recommended)

These functions take a native Wolfram `Image` object as input, perform the operations entirely in memory using Rust, and return a new Wolfram `Image` object. They avoid all disk I/O, making them significantly faster for interactive use.

### `ImageLinkResizeMemory`
Resizes an image using the specified resampling filter.
```mathematica
img = RandomImage[1, {800, 600}, ColorSpace -> "RGB"];

(* Default resize using Triangle filter *)
resized = ImageLinkResizeMemory[img, {400, 300}];

(* Resize using a specific filter *)
resized = ImageLinkResizeMemory[img, {400, 300}, Method -> "Lanczos3"];
(* Available Methods: "Nearest", "Triangle", "CatmullRom", "Gaussian", "Lanczos3" *)
```

### `ImageLinkCropMemory`
Crops an image given `{x, y, width, height}`.
```mathematica
cropped = ImageLinkCropMemory[img, {100, 100, 200, 150}];
```

### `ImageLinkRotateMemory`
Rotates an image clockwise by exactly 90, 180, or 270 degrees.
```mathematica
rotated = ImageLinkRotateMemory[img, 90];
```

### `ImageLinkFlipMemory`
Flips an image vertically or horizontally.
```mathematica
flippedH = ImageLinkFlipMemory[img, "Horizontal"];
flippedV = ImageLinkFlipMemory[img, "Vertical"];
```

### `ImageLinkGrayscaleMemory`
Converts a color image to grayscale. Returns an image with `ColorSpace -> "Grayscale"`.
```mathematica
grayImg = ImageLinkGrayscaleMemory[img];
```

### `ImageLinkInvertMemory`
Inverts the colors of an image.
```mathematica
inverted = ImageLinkInvertMemory[img];
```

### `ImageLinkBlurMemory`
Applies a Gaussian blur with the specified `sigma`.
```mathematica
blurred = ImageLinkBlurMemory[img, 5.0];
```

### `ImageLinkUnsharpenMemory`
Applies an unsharp mask filter given a `sigma` and a `threshold`.
```mathematica
unsharpened = ImageLinkUnsharpenMemory[img, 1.5, 10];
```

---

## 2. File-Based Processing

These functions process files directly. You provide an absolute or relative path to the input and output images. The Rust library will handle decoding the source and encoding the destination.

### `ImageLinkResize`
```mathematica
ImageLinkResize["input.png", "output.png", {400, 300}, Method -> "Lanczos3"]
```

### `ImageLinkCrop`
```mathematica
ImageLinkCrop["input.png", "output.png", {10, 10, 100, 100}]
```

### `ImageLinkRotate`
```mathematica
ImageLinkRotate["input.png", "output.png", 90]
```

### `ImageLinkFlip`
```mathematica
ImageLinkFlip["input.png", "output.png", "Horizontal"]
```

### `ImageLinkGrayscale`
```mathematica
ImageLinkGrayscale["input.png", "output.png"]
```

### `ImageLinkInvert`
```mathematica
ImageLinkInvert["input.png", "output.png"]
```

### `ImageLinkBlur`
```mathematica
ImageLinkBlur["input.png", "output.png", 5.0]
```

### `ImageLinkUnsharpen`
```mathematica
ImageLinkUnsharpen["input.png", "output.png", 1.5, 10]
```

---

## 3. Metadata Utility Functions

These functions quickly extract metadata directly from a file without loading the entire image into memory.

### `ImageLinkDimensions`
Returns the dimensions `{width, height}` of the image file.
```mathematica
dims = ImageLinkDimensions["input.png"]
(* Returns: {800, 600} *)
```

### `ImageLinkColorType`
Returns the color format of the image file (e.g., `Rgb8`, `Rgba8`, `Luma8`).
```mathematica
colorType = ImageLinkColorType["input.png"]
```

---

## Versioning

### `ImageLinkVersion`
Returns the current underlying version of the Rust dynamic library.
```mathematica
version = ImageLinkVersion[]
(* Returns: "0.1.0" *)
```
