# ImageLinkIntegralImageMemory

`ImageLinkIntegralImageMemory[image]` computes the integral image (summed-area table) of a Wolfram Language `Image` object directly in memory.

## Parameters

*   **image** (Image): The input Wolfram Language `Image` object.

## Returns

*   **Matrix**: A matrix of 32-bit unsigned integers representing the integral image.

## Description

An integral image allows for rapid calculation of the sum of pixel intensities within any rectangular sub-region of the original image in constant time O(1).

## Examples

### Compute Integral Image

```wolfram
img = Import["ExampleData/lena.tif"];
integral = ImageLinkIntegralImageMemory[img];
```

## See Also

* [ImageLinkIntegralSquaredImageMemory](ImageLinkIntegralSquaredImageMemory.md): Computes the integral of squared pixel intensities.
* [ImageLinkEvaluateHaarFeaturesMemory](ImageLinkEvaluateHaarFeaturesMemory.md): Uses integral images for feature evaluation.
