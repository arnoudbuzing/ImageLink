# ImageLinkRotateAboutCenterMemory

`ImageLinkRotateAboutCenterMemory[image, theta]` rotates a Wolfram Language `Image` object clockwise about its center by an arbitrary angle.

## Parameters

*   **image** (Image): The input Wolfram Language `Image` object.
*   **theta** (Numeric): The rotation angle in radians.

## Options

### Interpolation

The function supports different interpolation methods (passed as an integer):
- `1`: Nearest Neighbor
- `2`: Bilinear (**Default**)
- `3`: Bicubic

## Returns

*   **Image**: A new rotated `Image` object.

## Examples

### Rotate by 45 Degrees (π/4 radians)

```wolfram
img = Import["ExampleData/lena.tif"];
rotated = ImageLinkRotateAboutCenterMemory[img, Pi/4.0]
```

## See Also

* [ImageLinkRotateMemory](ImageLinkRotateMemory.md): Rotates by fixed multiples of 90 degrees.
* [ImageLinkAffineMemory](ImageLinkAffineMemory.md): General affine transformation.
