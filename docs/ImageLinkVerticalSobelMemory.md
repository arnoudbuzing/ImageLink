# ImageLinkVerticalSobelMemory

`ImageLinkVerticalSobelMemory[image]` computes the vertical component (Gy) of the Sobel gradient for a Wolfram Language `Image` object.

## Parameters

*   **image** (Image): The input Wolfram Language `Image` object.

## Returns

*   **Matrix**: A matrix of 16-bit integers representing the vertical gradient values.

## Examples

### Compute Vertical Sobel Gradient

```wolfram
img = Import["ExampleData/lena.tif"];
gy = ImageLinkVerticalSobelMemory[img];
(* Visualize as an image *)
Image[gy, "Bit16"]
```

## See Also

* [ImageLinkHorizontalSobelMemory](ImageLinkHorizontalSobelMemory.md): Computes the horizontal Sobel gradient.
* [ImageLinkSobelGradientsMemory](ImageLinkSobelGradientsMemory.md): Computes the combined gradient magnitude.
