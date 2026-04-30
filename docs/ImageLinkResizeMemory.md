# ImageLinkResizeMemory

`ImageLinkResizeMemory[image, {width, height}]` resizes a Wolfram Language `Image` object directly in memory.

## Parameters

*   **image** (Image): The input Wolfram Language `Image` object.
*   **{width, height}** (List of Integers): The target dimensions.

## Options

### Method

The `Method` option specifies the interpolation algorithm.

| Value | Description |
| :--- | :--- |
| `"Nearest"` | Nearest neighbor interpolation. Fastest but lowest quality. |
| `"Triangle"` | Bilinear interpolation. Balanced speed and quality. (**Default**) |
| `"CatmullRom"` | Catmull-Rom cubic interpolation. |
| `"Gaussian"` | Gaussian interpolation. |
| `"Lanczos3"` | Lanczos interpolation with a window size of 3. High quality. |

## Returns

*   **Image**: A new resized `Image` object.

## Examples

### Resize an Image Object

```wolfram
img = Import["ExampleData/lena.tif"];
resized = ImageLinkResizeMemory[img, {100, 100}]
```

## See Also

* [ImageLinkResize](ImageLinkResize.md): Resizes an image file.
* [ImageLinkShrinkWidthMemory](ImageLinkShrinkWidthMemory.md): Shrinks an image width using seam carving.
