# ImageLinkRotate

`ImageLinkRotate[input, output, angle]` rotates an image file by a specified angle and saves the result.

## Parameters

*   **input** (String): The file path to the input image.
*   **output** (String): The file path where the rotated image will be saved.
*   **angle** (Integer): The rotation angle in degrees. Supported values are `90`, `180`, and `270`.

## Description

The rotation is performed clockwise. For rotations of 90 and 270 degrees, the width and height of the image will be swapped.

## Examples

### Rotate 90 Degrees

```wolfram
ImageLinkRotate["input.jpg", "rotated_90.jpg", 90]
```

### Rotate 180 Degrees

```wolfram
ImageLinkRotate["input.jpg", "rotated_180.jpg", 180]
```

## See Also

* [ImageLinkRotateMemory](ImageLinkRotateMemory.md): Rotates an Image object directly in memory.
* [ImageLinkFlip](ImageLinkFlip.md): Flips an image file.
* [ImageLinkRotateAboutCenterMemory](ImageLinkRotateAboutCenterMemory.md): Rotates an image by an arbitrary angle about its center.
