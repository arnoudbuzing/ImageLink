# ImageLinkMinAreaRectMemory

`ImageLinkMinAreaRectMemory[points]` computes the vertices of the minimum area rectangle that encloses a given set of 2D points.

## Parameters

*   **points** (List of coordinate pairs): A list of points `{{x1, y1}, {x2, y2}, ...}`.

## Returns

*   **List of coordinate pairs**: A list of 4 points defining the vertices of the minimum area rectangle.

## Examples

### Compute Minimum Area Rectangle

```wolfram
points = {{0, 0}, {100, 0}, {50, 50}, {50, -50}};
rect = ImageLinkMinAreaRectMemory[points];
```

## See Also

* [ImageLinkConvexHullMemory](ImageLinkConvexHullMemory.md): Computes the convex hull.
* [ImageLinkApproximatePolygonMemory](ImageLinkApproximatePolygonMemory.md): Approximates a set of points with a polygon.
