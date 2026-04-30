# ImageLinkCornersFast9Memory

`ImageLinkCornersFast9Memory[image, threshold]` detects corner features in a Wolfram Language `Image` object using the FAST-9 algorithm.

## Parameters

*   **image** (Image): The input Wolfram Language `Image` object.
*   **threshold** (Integer): The intensity threshold for corner detection.

## Returns

*   **List of coordinate pairs**: A list of `{{x1, y1}, {x2, y2}, ...}` coordinates where corners were detected.

## Examples

### Detect Corners

```wolfram
img = Import["ExampleData/lena.tif"];
corners = ImageLinkCornersFast9Memory[img, 20];
(* Mark corners on the image *)
HighlightImage[img, Point /@ corners]
```

## See Also

* [ImageLinkCornersFast12Memory](ImageLinkCornersFast12Memory.md): Corner detection using FAST-12.
* [ImageLinkHogMemory](ImageLinkHogMemory.md): Computes HOG descriptors.
