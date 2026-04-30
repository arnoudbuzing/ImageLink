# ImageLinkMedianFilterMemory

`ImageLinkMedianFilterMemory[image, xRadius, yRadius]` applies a median filter to a Wolfram Language `Image` object directly in memory.

## Parameters

*   **image** (Image): The input Wolfram Language `Image` object.
*   **xRadius** (Integer): The horizontal radius of the median filter window.
*   **yRadius** (Integer): The vertical radius of the median filter window.

## Returns

*   **Image**: A new filtered `Image` object.

## Examples

### Apply Median Filter

```wolfram
img = Import["ExampleData/lena.tif"];
filtered = ImageLinkMedianFilterMemory[img, 2, 2]
```

## See Also

* [ImageLinkBlurMemory](ImageLinkBlurMemory.md): Applies a Gaussian blur.
* [ImageLinkBilateralFilterMemory](ImageLinkBilateralFilterMemory.md): Applies a bilateral filter.
