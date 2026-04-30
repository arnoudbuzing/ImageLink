# ImageLinkCrop

`ImageLinkCrop[input, output, {x, y, w, h}]` crops a rectangular region from an image file and saves the result.

## Parameters

*   **input** (String): The file path to the input image.
*   **output** (String): The file path where the cropped image will be saved.
*   **{x, y, w, h}** (List of Integers): The crop parameters:
    *   `x`: The x-coordinate of the top-left corner.
    *   `y`: The y-coordinate of the top-left corner.
    *   `w`: The width of the cropped region.
    *   `h`: The height of the cropped region.

## Examples

### Crop a 100x100 square from the top-left

```wolfram
ImageLinkCrop["input.jpg", "crop.jpg", {0, 0, 100, 100}]
```

### Crop from the center

Assuming an image of 800x600, to crop a 200x200 central region:

```wolfram
ImageLinkCrop["photo.png", "center_crop.png", {300, 200, 200, 200}]
```

## See Also

* [ImageLinkCropMemory](ImageLinkCropMemory.md): Crops an Image object directly in memory.
* [ImageLinkDimensions](ImageLinkDimensions.md): Get the dimensions of an image to calculate crop coordinates.
