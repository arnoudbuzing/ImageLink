# ImageLinkVerticalScharrMemory

`ImageLinkVerticalScharrMemory[image]` computes the vertical component (Gy) of the Scharr gradient for a Wolfram Language `Image` object.

## Parameters

*   **image** (Image): The input Wolfram Language `Image` object.

## Returns

*   **Matrix**: A matrix of 16-bit integers representing the vertical gradient values.

## Description

The Scharr operator provides better rotational invariance than the standard Sobel operator for small kernels.

## Examples

### Compute Vertical Scharr Gradient

```wolfram
img = Import["ExampleData/lena.tif"];
gy = ImageLinkVerticalScharrMemory[img];
Image[gy, "Bit16"]
```

## See Also

* [ImageLinkHorizontalScharrMemory](ImageLinkHorizontalScharrMemory.md): Computes the horizontal Scharr gradient.
* [ImageLinkSobelGradientsMemory](ImageLinkSobelGradientsMemory.md): Standard Sobel operator.
