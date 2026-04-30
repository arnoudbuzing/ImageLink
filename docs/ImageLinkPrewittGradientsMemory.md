# ImageLinkPrewittGradientsMemory

`ImageLinkPrewittGradientsMemory[image]` computes the 2D Prewitt gradient magnitude of a Wolfram Language `Image` object directly in memory.

## Parameters

*   **image** (Image): The input Wolfram Language `Image` object.

## Returns

*   **Image**: A new 16-bit grayscale `Image` object representing the gradient magnitude.

## Examples

### Compute Prewitt Gradients

```wolfram
img = Import["ExampleData/lena.tif"];
gradients = ImageLinkPrewittGradientsMemory[img]
```

## See Also

* [ImageLinkSobelGradientsMemory](ImageLinkSobelGradientsMemory.md): Uses the Sobel operator.
* [ImageLinkHorizontalPrewittMemory](ImageLinkHorizontalPrewittMemory.md): Computes only the horizontal Prewitt gradient.
