# ImageLinkKapurLevelMemory

`ImageLinkKapurLevelMemory[image]` computes the optimal threshold level for a Wolfram `Image` object using Kapur's entropy-based method.

## Parameters

*   **image** (Image): The input Wolfram `Image` object.

## Output

Returns an `Integer` between `0` and `255` representing the optimal threshold level.

## Examples

### Computing Kapur's Threshold

Compute the optimal threshold for a standard test image:

```wolfram
img = ExampleData[{"TestImage", "Lena"}];
level = ImageLinkKapurLevelMemory[img]
(* Returns an integer, e.g., 127 *)
```

### Applying the Threshold

Use the computed level to binarize the image:

```wolfram
binarized = Binarize[img, level/255.]
```

## Remarks

*   **Entropy-Based**: Kapur's method is based on maximizing the entropy of the foreground and background regions. It is often used for segmenting objects from their background.
*   **Implementation**: This function uses the `imageproc::contrast::kapur_level` implementation in Rust for maximum performance.
*   **Memory Efficiency**: Operates directly on the in-memory image buffer.

## See Also

*   `ImageLinkOtsuLevelMemory`: Computes the threshold using Otsu's method.
*   `ImageLinkAdaptiveThresholdMemory`: Performs local adaptive thresholding.
*   `ImageLinkEqualizeHistogramMemory`: Enhances image contrast.
