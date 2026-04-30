# ImageLinkDrawEllipseMemory

`ImageLinkDrawEllipseMemory[image, {x, y}, {rx, ry}, color]` draws an ellipse on a Wolfram Language `Image` object directly in memory.

## Parameters

*   **image** (Image): The input Wolfram Language `Image` object.
*   **{x, y}** (List of Integers): The coordinates of the center.
*   **{rx, ry}** (List of Integers): The horizontal (`rx`) and vertical (`ry`) radii.
*   **color** (List): A list of numeric values (0 to 1) representing the color.

## Options

### Filled

`Filled` specifies whether to fill the ellipse with the given color.

| Value | Description |
| :--- | :--- |
| `True` | The ellipse is filled. |
| `False` | Only the boundary is drawn. (**Default**) |

## Returns

*   **Image**: The `Image` object with the ellipse drawn.

## Examples

### Draw an Ellipse

```wolfram
img = ImageCreate[{500, 500}, 1];
drawn = ImageLinkDrawEllipseMemory[img, {250, 250}, {150, 80}, {0.5, 0.5, 0}]
```

## See Also

* [ImageLinkDrawCircleMemory](ImageLinkDrawCircleMemory.md): Draws a circle.
* [ImageLinkDrawBezierMemory](ImageLinkDrawBezierMemory.md): Draws a Bezier curve.
