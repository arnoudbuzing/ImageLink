# ImageLinkContourAreaMemory

`ImageLinkContourAreaMemory[points]` computes the area enclosed by a set of points (a contour).

## Parameters

*   **points** (List of coordinate pairs): A list of points `{{x1, y1}, {x2, y2}, ...}`.

## Returns

*   **Real**: The area of the contour.

## Examples

### Compute Contour Area

```wolfram
img = Import["ExampleData/lena.tif"];
contours = ImageLinkFindContoursMemory[img, 128];
area = ImageLinkContourAreaMemory[contours[[1, "Points"]]]
```

## See Also

* [ImageLinkArcLengthMemory](ImageLinkArcLengthMemory.md): Computes the arc length of a contour.
* [ImageLinkFindContoursMemory](ImageLinkFindContoursMemory.md): Detects contours in an image.
