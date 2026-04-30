# ImageLinkHoughLinesMemory

`ImageLinkHoughLinesMemory[image, voteThreshold, suppressionRadius]` detects lines in a binary Wolfram Language `Image` object using the Hough transform.

## Parameters

*   **image** (Image): The input binary Wolfram Language `Image` object.
*   **voteThreshold** (Integer): The minimum number of votes in the Hough accumulator to consider a line valid. Default is `10`.
*   **suppressionRadius** (Integer): The radius used for local maximum suppression in the accumulator. Default is `8`.

## Returns

*   **List of Vectors**: A list of detected lines, where each line is represented as `{rho, theta}` (distance from origin and angle in radians).

## Examples

### Detect Lines

```wolfram
img = Binarize[Import["ExampleData/lena.tif"]];
lines = ImageLinkHoughLinesMemory[img, 10, 8];
(* Draw the detected lines *)
```

## See Also

* [ImageLinkFindContoursMemory](ImageLinkFindContoursMemory.md): Detects contours.
* [ImageLinkCannyMemory](ImageLinkCannyMemory.md): Edge detection.
