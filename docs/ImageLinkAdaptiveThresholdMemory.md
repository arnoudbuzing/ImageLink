# ImageLinkAdaptiveThresholdMemory

`ImageLinkAdaptiveThresholdMemory[image, blockRadius, delta]` applies an adaptive threshold to a Wolfram Language `Image` object directly in memory.

## Parameters

*   **image** (Image): The input Wolfram Language `Image` object.
*   **blockRadius** (Integer): The radius of the local neighborhood used for calculating the threshold.
*   **delta** (Integer): A constant subtracted from the mean or weighted mean.

## Returns

*   **Image**: A new binary (grayscale, 1 channel) `Image` object.

## Examples

### Apply Adaptive Threshold

```wolfram
img = Import["ExampleData/lena.tif"];
binary = ImageLinkAdaptiveThresholdMemory[img, 5, 10]
```

## See Also

* [ImageLinkOtsuLevelMemory](ImageLinkOtsuLevelMemory.md): Global thresholding using Otsu's method.
* [ImageLinkKapurLevelMemory](ImageLinkKapurLevelMemory.md): Global thresholding using Kapur's method.
