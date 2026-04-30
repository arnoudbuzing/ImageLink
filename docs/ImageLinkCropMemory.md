# ImageLinkCropMemory

`ImageLinkCropMemory[image, {x, y, w, h}]` crops a rectangular region from a Wolfram Language `Image` object directly in memory.

## Parameters

*   **image** (Image): The input Wolfram Language `Image` object.
*   **{x, y, w, h}** (List of Integers): The crop parameters:
    *   `x`: The x-coordinate of the top-left corner.
    *   `y`: The y-coordinate of the top-left corner.
    *   `w`: The width of the cropped region.
    *   `h`: The height of the cropped region.

## Returns

*   **Image**: A new cropped `Image` object.

## Examples

### Crop an Image Object

```wolfram
img = Import["ExampleData/lena.tif"];
cropped = ImageLinkCropMemory[img, {50, 50, 200, 200}]
```

## See Also

* [ImageLinkCrop](ImageLinkCrop.md): Crops an image file.
* [ImageLinkResizeMemory](ImageLinkResizeMemory.md): Resizes an Image object in memory.
