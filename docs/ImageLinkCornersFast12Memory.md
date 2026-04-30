# ImageLinkCornersFast12Memory

`ImageLinkCornersFast12Memory[image, threshold]` detects corner features in a Wolfram Language `Image` object using the FAST-12 algorithm.

## Parameters

*   **image** (Image): The input Wolfram Language `Image` object.
*   **threshold** (Integer): The intensity threshold for corner detection.

## Returns

*   **List of coordinate pairs**: A list of `{{x1, y1}, {x2, y2}, ...}` coordinates where corners were detected.

## Examples

### Detect Corners

```wolfram
img = Import["ExampleData/lena.tif"];
corners = ImageLinkCornersFast12Memory[img, 20];
(* Mark corners on the image *)
HighlightImage[img, Point /@ corners]
```

## See Also

* [ImageLinkCornersFast9Memory](ImageLinkCornersFast9Memory.md): Corner detection using FAST-9.
