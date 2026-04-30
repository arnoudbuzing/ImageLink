# ImageLinkDistanceTransformMemory

`ImageLinkDistanceTransformMemory[image, norm]` computes the distance transform of a binary Wolfram Language `Image` object directly in memory.

## Parameters

*   **image** (Image): The input binary Wolfram Language `Image` object.
*   **norm** (Integer): The distance metric to use:
    *   `1`: L1 (Manhattan) distance.
    *   `2`: LInf (Chebyshev) distance.

## Returns

*   **Image**: A grayscale `Image` object where each pixel's value is its distance to the nearest background pixel.

## Examples

### Compute Distance Transform

```wolfram
img = Binarize[Import["ExampleData/lena.tif"]];
dist = ImageLinkDistanceTransformMemory[img, 1]
```

## See Also

* [ImageLinkCannyMemory](ImageLinkCannyMemory.md): Edge detection.
* [ImageLinkConnectedComponentsMemory](ImageLinkConnectedComponentsMemory.md): Labels connected regions.
