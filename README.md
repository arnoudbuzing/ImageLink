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

## 2. Advanced Image Processing & Computer Vision (In-Memory)

The paclet provides advanced operations leveraging the `imageproc` Rust library. These operate directly on Wolfram `Image` objects.

### `ImageLinkCannyMemory`
Applies Canny edge detection. Requires lower and upper thresholds. Returns a binary grayscale image.
```mathematica
edges = ImageLinkCannyMemory[img, 50.0, 100.0];
```

### `ImageLinkDilateMemory` & `ImageLinkErodeMemory`
Performs morphological dilation and erosion using a square structural element of the given radius. Properly processes each channel independently, preserving your original color space.
```mathematica
dilated = ImageLinkDilateMemory[img, 2];
eroded = ImageLinkErodeMemory[img, 2];
```

### `ImageLinkMedianFilterMemory`
Applies a median filter, highly effective at removing salt-and-pepper noise while preserving edges.
```mathematica
smoothed = ImageLinkMedianFilterMemory[img, 3, 3];
```

### `ImageLinkFilter3x3Memory`
Applies a custom 3x3 convolution kernel directly to the image buffers.
```mathematica
kernel = {{-1, -1, -1}, 
          {-1,  8, -1}, 
          {-1, -1, -1}};
sharpened = ImageLinkFilter3x3Memory[img, kernel];
```

### `ImageLinkEqualizeHistogramMemory`
Normalizes the contrast of the image. Operates independently across channels to preserve RGB structures without collapsing to grayscale.
```mathematica
autoLevelImg = ImageLinkEqualizeHistogramMemory[img];
```

### `ImageLinkAdaptiveThresholdMemory`
Applies adaptive local thresholding. Ideal for OCR, document scanning, and unevenly lit images. Converts to Grayscale internally and returns a binary threshold mask.
```mathematica
(* Uses a 5x5 block radius with a delta of 2 *)
binaryScan = ImageLinkAdaptiveThresholdMemory[img, 5, 2];
```

---

## 3. Drawing & Annotations (In-Memory)

Draw anti-aliased primitives natively on your image buffers. Colors are provided as normalized lists `(e.g., {R, G, B})`.

### `ImageLinkDrawLineMemory`
Draws a line segment between any two `(x, y)` float coordinates.
```mathematica
(* Draw a thick red line *)
lineImg = ImageLinkDrawLineMemory[img, {10, 10}, {200, 200}, {1, 0, 0}];
```

### `ImageLinkDrawRectangleMemory`
Draws a rectangle starting at integer coordinates `{x, y}` with `width` and `height`.
```mathematica
(* Draw a hollow green bounding box *)
hollowRect = ImageLinkDrawRectangleMemory[img, {50, 50, 100, 150}, {0, 1, 0}];

(* Draw a solid filled blue box *)
filledRect = ImageLinkDrawRectangleMemory[img, {100, 100, 50, 50}, {0, 0, 1}, Filled -> True];
```

### `ImageLinkDrawCircleMemory` & `ImageLinkDrawEllipseMemory`
Draws hollow or filled circles and ellipses.
```mathematica
(* Draw a solid green circle of radius 50 at {250, 150} *)
circleImg = ImageLinkDrawCircleMemory[img, {250, 150}, 50, {0, 1, 0}, Filled -> True];

(* Draw a hollow blue ellipse at {150, 300} with radii {80, 40} *)
ellipseImg = ImageLinkDrawEllipseMemory[img, {150, 300}, {80, 40}, {0, 0, 1}];
```

### `ImageLinkDrawPolygonMemory`
Draws a hollow or filled polygon from a list of `{x, y}` coordinate pairs.
```mathematica
(* Draw a solid yellow polygon *)
polyImg = ImageLinkDrawPolygonMemory[img, {{50, 50}, {150, 100}, {100, 200}, {20, 150}}, {1, 1, 0}, Filled -> True];
```

---

## 4. Seam Carving (Content-Aware Scaling)

Seam carving allows you to shrink an image's dimensions while preserving its most important features, dynamically removing the "least noticeable" paths (seams) of pixels.

### `ImageLinkShrinkWidthMemory`
Shrinks the width of the image to the specified target width.
```mathematica
(* Shrink the image width to 500 pixels *)
shrunkImg = ImageLinkShrinkWidthMemory[img, 500];
```

---

## 5. File-Based Processing

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

## 6. Metadata Utility Functions

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

## 7. Versioning

### `ImageLinkVersion`
Returns the current underlying version of the Rust dynamic library.
```mathematica
version = ImageLinkVersion[]
(* Returns: "0.1.0" *)
```
---

## 8. Development & Testing

### Running Unit Tests
The project includes a comprehensive suite of unit tests. To run the full test report:

```bash
/Applications/Wolfram/15.0/Wolfram.app/Contents/MacOS/wolfram -script scripts/report.wl
```

This will execute all `.wlt` files in the `tests/` directory and display a summary of results.

### Building from Source
To build the Rust LibraryLink extension:

1. Ensure you have [Rust](https://rustup.rs/) installed.
2. Navigate to the `rust/` directory.
3. Run the build command:
   ```bash
   cargo build --release
   ```
4. Copy the compiled library to the paclet resources:
   ```bash
   cp target/release/librust.dylib ../ImageLink/LibraryResources/MacOSX-ARM64/
   ```
