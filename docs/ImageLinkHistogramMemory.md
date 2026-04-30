# ImageLinkHistogramMemory

`ImageLinkHistogramMemory[image]` computes the intensity histogram for each channel of a Wolfram Language `Image` object directly in memory.

## Parameters

*   **image** (Image): The input Wolfram Language `Image` object.

## Returns

*   **List of Lists**: A list where each element is a list of 256 integers representing the histogram of a channel. For an RGB image, the result is `{{redHistogram}, {greenHistogram}, {blueHistogram}}`.

## Examples

### Compute and Plot Histogram

```wolfram
img = Import["ExampleData/lena.tif"];
hists = ImageLinkHistogramMemory[img];
ListLinePlot[hists, PlotRange -> All, PlotLegends -> {"Red", "Green", "Blue"}]
```

## See Also

* [ImageLinkEqualizeHistogramMemory](ImageLinkEqualizeHistogramMemory.md): Equalizes the histogram of an image.
* [ImageLinkMatchHistogramMemory](ImageLinkMatchHistogramMemory.md): Matches histograms between two images.
