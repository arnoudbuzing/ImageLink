# ImageLinkFilter3x3Memory

`ImageLinkFilter3x3Memory[image, kernel]` applies a custom 3x3 convolution kernel to a Wolfram Language `Image` object directly in memory.

## Parameters

*   **image** (Image): The input Wolfram Language `Image` object.
*   **kernel** (Matrix): A 3x3 matrix of numeric values.

## Returns

*   **Image**: A new `Image` object with the filter applied.

## Examples

### Apply a Sharpening Filter

```wolfram
img = Import["ExampleData/lena.tif"];
kernel = {{0, -1, 0}, {-1, 5, -1}, {0, -1, 0}};
sharpened = ImageLinkFilter3x3Memory[img, kernel]
```

### Apply a Sobel Filter (Approximate)

```wolfram
sobelX = {{-1, 0, 1}, {-2, 0, 2}, {-1, 0, 1}};
edges = ImageLinkFilter3x3Memory[img, sobelX]
```

## See Also

* [ImageLinkSobelGradientsMemory](ImageLinkSobelGradientsMemory.md): Specialized Sobel gradient operator.
* [ImageLinkLaplacianFilterMemory](ImageLinkLaplacianFilterMemory.md): Specialized Laplacian filter.
