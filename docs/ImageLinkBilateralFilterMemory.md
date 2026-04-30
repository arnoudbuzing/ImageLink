# ImageLinkBilateralFilterMemory

`ImageLinkBilateralFilterMemory[image, radius, sigmaSpatial, sigmaColor]` applies a bilateral filter to a Wolfram Language `Image` object directly in memory.

## Parameters

*   **image** (Image): The input Wolfram Language `Image` object.
*   **radius** (Integer): The filter radius.
*   **sigmaSpatial** (Numeric): The spatial standard deviation (controls how far pixels can influence each other).
*   **sigmaColor** (Numeric): The color standard deviation (controls how different in color pixels can be while still influencing each other).

## Returns

*   **Image**: A new `Image` object with the bilateral filter applied.

## Description

Bilateral filtering is an edge-preserving smoothing technique. It reduces noise while keeping edges sharp.

## Examples

### Apply Bilateral Filter

```wolfram
img = Import["ExampleData/lena.tif"];
filtered = ImageLinkBilateralFilterMemory[img, 5, 2.0, 0.1]
```

## See Also

* [ImageLinkBlurMemory](ImageLinkBlurMemory.md): Standard Gaussian blur (non-edge-preserving).
* [ImageLinkMedianFilterMemory](ImageLinkMedianFilterMemory.md): Median filter (also edge-preserving).
