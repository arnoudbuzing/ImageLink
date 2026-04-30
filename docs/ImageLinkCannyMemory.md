# ImageLinkCannyMemory

`ImageLinkCannyMemory[image, low, high]` applies Canny edge detection to a Wolfram Language `Image` object directly in memory.

## Parameters

*   **image** (Image): The input Wolfram Language `Image` object.
*   **low** (Numeric): The low threshold for edge detection.
*   **high** (Numeric): The high threshold for edge detection.

## Returns

*   **Image**: A new binary `Image` object (grayscale, 1 channel) representing the detected edges.

## Examples

### Edge Detection on an Image Object

```wolfram
img = Import["ExampleData/lena.tif"];
edges = ImageLinkCannyMemory[img, 50, 100]
```

## See Also

* [ImageLinkSobelGradientsMemory](ImageLinkSobelGradientsMemory.md): Computes Sobel gradient magnitude.
* [ImageLinkFindContoursMemory](ImageLinkFindContoursMemory.md): Detects contours in an image.
