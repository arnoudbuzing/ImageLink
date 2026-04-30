# ImageLinkDrawBezierMemory

`ImageLinkDrawBezierMemory[image, {p1, p2, p3, p4}, color]` draws a cubic Bezier curve on a Wolfram Language `Image` object directly in memory.

## Parameters

*   **image** (Image): The input Wolfram Language `Image` object.
*   **{p1, p2, p3, p4}** (List of coordinate pairs): The four control points `{{x1, y1}, {x2, y2}, {x3, y3}, {x4, y4}}` defining the cubic Bezier curve.
*   **color** (List): A list of numeric values (0 to 1) representing the color.

## Returns

*   **Image**: The `Image` object with the Bezier curve drawn.

## Examples

### Draw a Bezier Curve

```wolfram
img = ImageCreate[{500, 500}, 1];
p1 = {50, 250};
p2 = {150, 50};
p3 = {350, 450};
p4 = {450, 250};
drawn = ImageLinkDrawBezierMemory[img, {p1, p2, p3, p4}, {0, 0, 1}]
```

## See Also

* [ImageLinkDrawAntialiasedLineMemory](ImageLinkDrawAntialiasedLineMemory.md): Draws an anti-aliased line.
* [ImageLinkDrawPolygonMemory](ImageLinkDrawPolygonMemory.md): Draws a polygon.
