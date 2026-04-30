# ImageLinkEqualizeHistogramMemory

`ImageLinkEqualizeHistogramMemory[image]` performs histogram equalization on a Wolfram Language `Image` object directly in memory.

## Parameters

*   **image** (Image): The input Wolfram Language `Image` object.

## Returns

*   **Image**: A new `Image` object with equalized histogram.

## Description

Histogram equalization improves the contrast of an image by spreading out the most frequent intensity values.

## Examples

### Equalize Histogram

```wolfram
img = Import["ExampleData/lena.tif"];
equalized = ImageLinkEqualizeHistogramMemory[img]
```

## See Also

* [ImageLinkMatchHistogramMemory](ImageLinkMatchHistogramMemory.md): Matches the histogram to a target image.
* [ImageLinkHistogramMemory](ImageLinkHistogramMemory.md): Computes the histogram of an image.
