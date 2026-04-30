# ImageLinkSuppressNonMaximumMemory

`ImageLinkSuppressNonMaximumMemory[image, radius]` performs non-maximum suppression (NMS) on a Wolfram Language `Image` object directly in memory.

## Parameters

*   **image** (Image): The input Wolfram Language `Image` object.
*   **radius** (Integer): The suppression radius. Only local maximums within this radius are preserved.

## Returns

*   **Image**: A new `Image` object with non-maximum values suppressed (set to zero).

## Description

NMS is often used in feature detection (e.g., after edge detection or corner detection) to refine the location of features.

## Examples

### Perform Non-Maximum Suppression

```wolfram
img = Import["ExampleData/lena.tif"];
sobel = ImageLinkSobelGradientsMemory[img];
nms = ImageLinkSuppressNonMaximumMemory[sobel, 2]
```

## See Also

* [ImageLinkCornersFast9Memory](ImageLinkCornersFast9Memory.md): Corner detection (often uses NMS internally).
* [ImageLinkCannyMemory](ImageLinkCannyMemory.md): Edge detection.
