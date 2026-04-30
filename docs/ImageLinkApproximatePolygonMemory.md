# ImageLinkApproximatePolygonMemory

`ImageLinkApproximatePolygonMemory[points, epsilon]` approximates a curve or set of points with a polygon using the Douglas-Peucker algorithm.

## Parameters

*   **points** (List of coordinate pairs): A list of points `{{x1, y1}, {x2, y2}, ...}`.
*   **epsilon** (Numeric): The maximum distance between the original curve and its approximation. A larger value results in a simpler polygon (fewer vertices).

## Returns

*   **List of coordinate pairs**: The vertices of the approximated polygon.

## Examples

### Simplify a Contour

```wolfram
img = Import["ExampleData/lena.tif"];
contours = ImageLinkFindContoursMemory[img, 128];
poly = ImageLinkApproximatePolygonMemory[contours[[1, "Points"]], 2.0];
```

## See Also

* [ImageLinkArcLengthMemory](ImageLinkArcLengthMemory.md): Computes the arc length of a contour.
* [ImageLinkFindContoursMemory](ImageLinkFindContoursMemory.md): Detects contours in an image.
