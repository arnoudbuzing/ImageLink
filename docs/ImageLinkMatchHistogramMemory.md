# ImageLinkMatchHistogramMemory

`ImageLinkMatchHistogramMemory[image, target]` adjusts the histogram of a Wolfram Language `Image` object to match the histogram of a target `Image` object directly in memory.

## Parameters

*   **image** (Image): The source Wolfram Language `Image` object to be adjusted.
*   **target** (Image): The reference Wolfram Language `Image` object.

## Returns

*   **Image**: A new `Image` object with the adjusted histogram.

## Examples

### Match Histogram

```wolfram
src = Import["ExampleData/lena.tif"];
ref = Import["ExampleData/cameraman.tif"];
matched = ImageLinkMatchHistogramMemory[src, ref]
```

## See Also

* [ImageLinkEqualizeHistogramMemory](ImageLinkEqualizeHistogramMemory.md): Equalizes the histogram of an image.
* [ImageLinkHistogramMemory](ImageLinkHistogramMemory.md): Computes the histogram of an image.
