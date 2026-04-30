# ImageLinkSobelGradientsMemory

`ImageLinkSobelGradientsMemory[image]` computes the 2D Sobel gradient magnitude of a Wolfram Language `Image` object directly in memory.

## Parameters

*   **image** (Image): The input Wolfram Language `Image` object.

## Returns

*   **Image**: A new 16-bit grayscale `Image` object representing the gradient magnitude.

## Description

The Sobel operator is used in image processing and computer vision, particularly within edge detection algorithms where it creates an image emphasizing edges.

## Examples

### Compute Sobel Gradients

```wolfram
img = Import["ExampleData/lena.tif"];
gradients = ImageLinkSobelGradientsMemory[img]
```

## See Also

* [ImageLinkHorizontalSobelMemory](ImageLinkHorizontalSobelMemory.md): Computes only the horizontal Sobel gradient.
* [ImageLinkVerticalSobelMemory](ImageLinkVerticalSobelMemory.md): Computes only the vertical Sobel gradient.
* [ImageLinkPrewittGradientsMemory](ImageLinkPrewittGradientsMemory.md): Uses the Prewitt operator.
