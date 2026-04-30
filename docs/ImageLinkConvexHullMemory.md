# ImageLinkConvexHullMemory

`ImageLinkConvexHullMemory[points]` computes the convex hull for a given set of 2D points.

## Parameters

*   **points** (List of coordinate pairs): A list of points `{{x1, y1}, {x2, y2}, ...}`.

## Returns

*   **List of coordinate pairs**: A list of points defining the vertices of the convex hull in order.

## Examples

### Compute Convex Hull

```wolfram
points = RandomInteger[{0, 100}, {50, 2}];
hull = ImageLinkConvexHullMemory[points];
```

### Compute Hull of a Contour

```wolfram
img = Import["ExampleData/lena.tif"];
contours = ImageLinkFindContoursMemory[img, 128];
hull = ImageLinkConvexHullMemory[contours[[1, "Points"]]];
```

## See Also

* [ImageLinkMinAreaRectMemory](ImageLinkMinAreaRectMemory.md): Computes the minimum area bounding rectangle.
* [ImageLinkFindContoursMemory](ImageLinkFindContoursMemory.md): Detects contours in an image.
