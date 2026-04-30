# ImageLinkArcLengthMemory

`ImageLinkArcLengthMemory[points, closed]` computes the perimeter or arc length of a curve defined by a set of points.

## Parameters

*   **points** (List of coordinate pairs): A list of points `{{x1, y1}, {x2, y2}, ...}`.
*   **closed** (Boolean): Whether the curve is closed (the last point is connected back to the first point). Default is `True`.

## Returns

*   **Real**: The total length of the curve.

## Examples

### Compute Contour Perimeter

```wolfram
img = Import["ExampleData/lena.tif"];
contours = ImageLinkFindContoursMemory[img, 128];
perimeter = ImageLinkArcLengthMemory[contours[[1, "Points"]], True]
```

## See Also

* [ImageLinkContourAreaMemory](ImageLinkContourAreaMemory.md): Computes the area of a closed contour.
* [ImageLinkApproximatePolygonMemory](ImageLinkApproximatePolygonMemory.md): Simplifies a contour.
