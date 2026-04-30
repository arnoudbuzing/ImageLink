# ImageLinkLaplacianFilterMemory

`ImageLinkLaplacianFilterMemory[image]` applies a Laplacian filter to a Wolfram Language `Image` object directly in memory.

## Parameters

*   **image** (Image): The input Wolfram Language `Image` object.

## Returns

*   **Matrix**: A matrix of 16-bit integers representing the Laplacian values.

## Description

The Laplacian filter is a second-order derivative operator that highlights regions of rapid intensity change and is often used for edge detection.

## Examples

### Apply Laplacian Filter

```wolfram
img = Import["ExampleData/lena.tif"];
laplacian = ImageLinkLaplacianFilterMemory[img];
Image[laplacian, "Bit16"]
```

## See Also

* [ImageLinkSobelGradientsMemory](ImageLinkSobelGradientsMemory.md): First-order derivative operator.
* [ImageLinkCannyMemory](ImageLinkCannyMemory.md): Advanced edge detection.
