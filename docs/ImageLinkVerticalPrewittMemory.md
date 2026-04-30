# ImageLinkVerticalPrewittMemory

`ImageLinkVerticalPrewittMemory[image]` computes the vertical component (Gy) of the Prewitt gradient for a Wolfram Language `Image` object.

## Parameters

*   **image** (Image): The input Wolfram Language `Image` object.

## Returns

*   **Matrix**: A matrix of 16-bit integers representing the vertical gradient values.

## Examples

### Compute Vertical Prewitt Gradient

```wolfram
img = Import["ExampleData/lena.tif"];
gy = ImageLinkVerticalPrewittMemory[img];
Image[gy, "Bit16"]
```

## See Also

* [ImageLinkHorizontalPrewittMemory](ImageLinkHorizontalPrewittMemory.md): Computes the horizontal Prewitt gradient.
* [ImageLinkPrewittGradientsMemory](ImageLinkPrewittGradientsMemory.md): Computes the combined gradient magnitude.
