# ImageLinkDrawPolygonMemory

`ImageLinkDrawPolygonMemory[image, points, color]` draws a polygon on a Wolfram Language `Image` object directly in memory.

## Parameters

*   **image** (Image): The input Wolfram Language `Image` object.
*   **points** (List of coordinate pairs): A list of points `{{x1, y1}, {x2, y2}, ...}` defining the polygon vertices.
*   **color** (List): A list of numeric values (0 to 1) representing the color.

## Options

### Filled

`Filled` specifies whether to fill the polygon with the given color.

| Value | Description |
| :--- | :--- |
| `True` | The polygon is filled. |
| `False` | Only the boundary is drawn. (**Default**) |

## Returns

*   **Image**: The `Image` object with the polygon drawn.

## Examples

### Draw a Triangle Outline

```wolfram
img = ImageCreate[{500, 500}, 1];
points = {{100, 100}, {400, 100}, {250, 400}};
drawn = ImageLinkDrawPolygonMemory[img, points, {1, 0.5, 0}]
```

### Draw a Filled Star-like shape

```wolfram
starPoints = {{250, 450}, {300, 350}, {450, 350}, {350, 250}, {400, 100}, {250, 200}, {100, 100}, {150, 250}, {50, 350}, {200, 350}};
drawn = ImageLinkDrawPolygonMemory[img, starPoints, {1, 1, 0}, Filled -> True]
```

## See Also

* [ImageLinkDrawBezierMemory](ImageLinkDrawBezierMemory.md): Draws a Bezier curve.
* [ImageLinkApproximatePolygonMemory](ImageLinkApproximatePolygonMemory.md): Simplifies a contour into a polygon.
