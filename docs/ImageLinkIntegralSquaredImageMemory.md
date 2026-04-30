# ImageLinkIntegralSquaredImageMemory

`ImageLinkIntegralSquaredImageMemory[image]` computes the integral image of squared pixel intensities for a Wolfram Language `Image` object.

## Parameters

*   **image** (Image): The input Wolfram Language `Image` object.

## Returns

*   **Matrix**: A matrix of 64-bit unsigned integers representing the integral squared image.

## Description

Integral squared images are useful for calculating local variance or standard deviation in constant time.

## Examples

### Compute Integral Squared Image

```wolfram
img = Import["ExampleData/lena.tif"];
integralSq = ImageLinkIntegralSquaredImageMemory[img];
```

## See Also

* [ImageLinkIntegralImageMemory](ImageLinkIntegralImageMemory.md): Computes the standard integral image.
