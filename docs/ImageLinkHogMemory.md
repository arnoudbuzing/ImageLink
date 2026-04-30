# ImageLinkHogMemory

`ImageLinkHogMemory[image, orientations, signed, cellSide, blockSide, blockStride]` computes the Histogram of Oriented Gradients (HOG) descriptor for a Wolfram `Image` object.

## Parameters

*   **image** (Image): The input Wolfram `Image` object (converted to grayscale internally).
*   **orientations** (Integer): Number of orientation bins (e.g., `8`).
*   **signed** (Boolean): Whether to use signed gradients (`True` or `False`). Signed gradients use the full [0, 360] range, while unsigned gradients use [0, 180].
*   **cellSide** (Integer): The size of each square cell in pixels (e.g., `8`). The image dimensions must be divisible by `cellSide`.
*   **blockSide** (Integer): The number of cells in each block (e.g., `2`).
*   **blockStride** (Integer): The number of cells to stride between blocks (e.g., `1`).

## Output

Returns a flat `List` of `Real32` values representing the concatenated and normalized HOG descriptors for all blocks in the image.

## Examples

### Computing a standard HOG descriptor

Compute the HOG descriptor for a 128x128 image using standard parameters:

```wolfram
img = Image[Table[If[(i-64)^2 + (j-64)^2 < 400, 255, 0], {i, 128}, {j, 128}], "Byte"];

(* 8 bins, signed, 8x8 cells, 2x2 blocks, stride of 1 cell *)
hog = ImageLinkHogMemory[img, 8, True, 8, 2, 1];

Length[hog]
(* Returns 7200 for a 128x128 image *)
```

### Visualizing HOG values

You can visualize parts of the descriptor as a list plot:

```wolfram
ListPlot[hog[[1;;100]], PlotRange -> All, Filling -> Axis]
```

## Remarks

*   **Dimensional Requirements**: The input image's width and height **must** be divisible by `cellSide`. For example, a 100x100 image will fail with a `cellSide` of 8.
*   **Memory Efficiency**: The descriptor is computed in-memory in Rust and returned as a packed array of `Real32` values.
*   **Performance**: HOG is a computationally intensive descriptor, but the Rust implementation is highly optimized.

## See Also

*   `ImageLinkEvaluateHaarFeaturesMemory`: Evaluates Haar features.
*   `ImageLinkLocalBinaryPatternMemory`: Computes LBP images.
*   `ImageLinkConnectedComponentsMemory`: Region labelling.
