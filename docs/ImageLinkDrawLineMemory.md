# ImageLinkDrawLineMemory

`ImageLinkDrawLineMemory[image, {x1, y1}, {x2, y2}, color]` draws a line segment on a Wolfram Language `Image` object directly in memory.

## Parameters

*   **image** (Image): The input Wolfram Language `Image` object.
*   **{x1, y1}** (List of Numerics): The coordinates of the start point.
*   **{x2, y2}** (List of Numerics): The coordinates of the end point.
*   **color** (List): A list of numeric values (0 to 1) representing the color (e.g., `{r, g, b}` or `{gray}`).

## Returns

*   **Image**: The `Image` object with the line drawn.

## Examples

### Draw a Red Line

```wolfram
img = ImageCreate[{500, 500}, 1];
drawn = ImageLinkDrawLineMemory[img, {10, 10}, {490, 490}, {1, 0, 0}]
```

## See Also

* [ImageLinkDrawAntialiasedLineMemory](ImageLinkDrawAntialiasedLineMemory.md): Draws a smooth, anti-aliased line.
* [ImageLinkDrawRectangleMemory](ImageLinkDrawRectangleMemory.md): Draws a rectangle.
