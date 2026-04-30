# ImageLinkOtsuLevelMemory

`ImageLinkOtsuLevelMemory[image]` computes the optimal threshold level for a Wolfram Language `Image` object using Otsu's method.

## Parameters

*   **image** (Image): The input Wolfram Language `Image` object.

## Returns

*   **Integer**: The optimal threshold value (0-255).

## Description

Otsu's method chooses a threshold that minimizes the intra-class variance of the black and white pixels.

## Examples

### Compute Otsu Threshold

```wolfram
img = Import["ExampleData/lena.tif"];
threshold = ImageLinkOtsuLevelMemory[img]
(* 117 *)
```

### Apply the Threshold

```wolfram
binary = Binarize[img, threshold/255.0]
```

## See Also

* [ImageLinkKapurLevelMemory](ImageLinkKapurLevelMemory.md): Thresholding using Kapur's method.
* [ImageLinkAdaptiveThresholdMemory](ImageLinkAdaptiveThresholdMemory.md): Local adaptive thresholding.
