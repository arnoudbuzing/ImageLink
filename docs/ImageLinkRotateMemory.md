# ImageLinkRotateMemory

`ImageLinkRotateMemory[image, angle]` rotates a Wolfram Language `Image` object by a specified angle directly in memory.

## Parameters

*   **image** (Image): The input Wolfram Language `Image` object.
*   **angle** (Integer): The rotation angle in degrees. Supported values are `90`, `180`, and `270`.

## Returns

*   **Image**: A new rotated `Image` object.

## Examples

### Rotate an Image Object 90 Degrees

```wolfram
img = Import["ExampleData/lena.tif"];
rotated = ImageLinkRotateMemory[img, 90]
```

## See Also

* [ImageLinkRotate](ImageLinkRotate.md): Rotates an image file.
* [ImageLinkRotateAboutCenterMemory](ImageLinkRotateAboutCenterMemory.md): Rotates an image by an arbitrary angle about its center.
