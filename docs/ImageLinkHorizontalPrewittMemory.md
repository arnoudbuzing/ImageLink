# ImageLinkHorizontalPrewittMemory

`ImageLinkHorizontalPrewittMemory[image]` computes the horizontal component (Gx) of the Prewitt gradient for a Wolfram Language `Image` object.

## Parameters

*   **image** (Image): The input Wolfram Language `Image` object.

## Returns

*   **Matrix**: A matrix of 16-bit integers representing the horizontal gradient values.

## Examples

### Compute Horizontal Prewitt Gradient

```wolfram
img = Import["ExampleData/lena.tif"];
gx = ImageLinkHorizontalPrewittMemory[img];
Image[gx, "Bit16"]
```

## See Also

* [ImageLinkVerticalPrewittMemory](ImageLinkVerticalPrewittMemory.md): Computes the vertical Prewitt gradient.
* [ImageLinkPrewittGradientsMemory](ImageLinkPrewittGradientsMemory.md): Computes the combined gradient magnitude.
