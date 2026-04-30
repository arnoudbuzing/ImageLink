# ImageLinkHorizontalSobelMemory

`ImageLinkHorizontalSobelMemory[image]` computes the horizontal component (Gx) of the Sobel gradient for a Wolfram Language `Image` object.

## Parameters

*   **image** (Image): The input Wolfram Language `Image` object.

## Returns

*   **Matrix**: A matrix of 16-bit integers representing the horizontal gradient values.

## Examples

### Compute Horizontal Sobel Gradient

```wolfram
img = Import["ExampleData/lena.tif"];
gx = ImageLinkHorizontalSobelMemory[img];
(* Visualize as an image *)
Image[gx, "Bit16"]
```

## See Also

* [ImageLinkVerticalSobelMemory](ImageLinkVerticalSobelMemory.md): Computes the vertical Sobel gradient.
* [ImageLinkSobelGradientsMemory](ImageLinkSobelGradientsMemory.md): Computes the combined gradient magnitude.
