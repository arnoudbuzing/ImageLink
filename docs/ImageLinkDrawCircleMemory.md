# ImageLinkDrawCircleMemory

`ImageLinkDrawCircleMemory[image, {x, y}, radius, color]` draws a circle on a Wolfram Language `Image` object directly in memory.

## Parameters

*   **image** (Image): The input Wolfram Language `Image` object.
*   **{x, y}** (List of Integers): The coordinates of the center.
*   **radius** (Integer): The radius of the circle.
*   **color** (List): A list of numeric values (0 to 1) representing the color.

## Options

### Filled

`Filled` specifies whether to fill the circle with the given color.

| Value | Description |
| :--- | :--- |
| `True` | The circle is filled. |
| `False` | Only the boundary is drawn. (**Default**) |

## Returns

*   **Image**: The `Image` object with the circle drawn.

## Examples

### Draw a Circle Outline

```wolfram
img = ImageCreate[{500, 500}, 1];
drawn = ImageLinkDrawCircleMemory[img, {250, 250}, 100, {0, 1, 0}]
```

### Draw a Filled Circle

```wolfram
drawn = ImageLinkDrawCircleMemory[img, {250, 250}, 50, {1, 0, 1}, Filled -> True]
```

## See Also

* [ImageLinkDrawEllipseMemory](ImageLinkDrawEllipseMemory.md): Draws an ellipse.
* [ImageLinkDrawRectangleMemory](ImageLinkDrawRectangleMemory.md): Draws a rectangle.
