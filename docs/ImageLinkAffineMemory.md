# ImageLinkAffineMemory

`ImageLinkAffineMemory[image, matrix]` applies a general 2D affine transformation to a Wolfram Language `Image` object.

## Parameters

*   **image** (Image): The input Wolfram Language `Image` object.
*   **matrix** (Matrix): A 3x3 affine transformation matrix.

## Options

### Interpolation

The function supports different interpolation methods (passed as an integer):
- `1`: Nearest Neighbor
- `2`: Bilinear (**Default**)
- `3`: Bicubic

## Returns

*   **Image**: A new transformed `Image` object.

## Examples

### Apply Affine Transformation

```wolfram
img = Import["ExampleData/lena.tif"];
(* A simple scaling matrix *)
matrix = {{1.5, 0, 0}, {0, 1.5, 0}, {0, 0, 1}};
transformed = ImageLinkAffineMemory[img, matrix]
```

## See Also

* [ImageLinkRotateAboutCenterMemory](ImageLinkRotateAboutCenterMemory.md): Specialized rotation about the center.
* [ImageLinkResizeMemory](ImageLinkResizeMemory.md): Specialized resizing.
