# ImageLinkDrawAntialiasedLineMemory

`ImageLinkDrawAntialiasedLineMemory[image, {x1, y1}, {x2, y2}, color]` draws a smooth, anti-aliased line segment on a Wolfram Language `Image` object directly in memory.

## Parameters

*   **image** (Image): The input Wolfram Language `Image` object.
*   **{x1, y1}** (List of Integers): The coordinates of the start point.
*   **{x2, y2}** (List of Integers): The coordinates of the end point.
*   **color** (List): A list of numeric values (0 to 1) representing the color.

## Returns

*   **Image**: The `Image` object with the line drawn.

## Description

Unlike `ImageLinkDrawLineMemory`, this function uses anti-aliasing to produce a smoother appearance, reducing "jagged" edges.

## Examples

### Draw an Anti-aliased Line

```wolfram
img = ImageCreate[{500, 500}, 1];
drawn = ImageLinkDrawAntialiasedLineMemory[img, {50, 50}, {450, 200}, {0, 0, 0}]
```

## See Also

* [ImageLinkDrawLineMemory](ImageLinkDrawLineMemory.md): Draws a standard line.
* [ImageLinkDrawBezierMemory](ImageLinkDrawBezierMemory.md): Draws a Bezier curve.
