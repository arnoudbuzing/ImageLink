# ImageLinkDrawRectangleMemory

`ImageLinkDrawRectangleMemory[image, {x, y, w, h}, color]` draws a rectangle on a Wolfram Language `Image` object directly in memory.

## Parameters

*   **image** (Image): The input Wolfram Language `Image` object.
*   **{x, y, w, h}** (List of Integers): The rectangle parameters:
    *   `x`: The x-coordinate of the top-left corner.
    *   `y`: The y-coordinate of the top-left corner.
    *   `w`: The width.
    *   `h`: The height.
*   **color** (List): A list of numeric values (0 to 1) representing the color.

## Options

### Filled

`Filled` specifies whether to fill the rectangle with the given color.

| Value | Description |
| :--- | :--- |
| `True` | The rectangle is filled. |
| `False` | Only the boundary is drawn. (**Default**) |

## Returns

*   **Image**: The `Image` object with the rectangle drawn.

## Examples

### Draw an Outline Rectangle

```wolfram
img = ImageCreate[{500, 500}, 1];
drawn = ImageLinkDrawRectangleMemory[img, {100, 100, 300, 200}, {0, 0, 1}]
```

### Draw a Filled Rectangle

```wolfram
drawn = ImageLinkDrawRectangleMemory[img, {150, 150, 200, 100}, {1, 1, 0}, Filled -> True]
```

## See Also

* [ImageLinkDrawCircleMemory](ImageLinkDrawCircleMemory.md): Draws a circle.
* [ImageLinkDrawPolygonMemory](ImageLinkDrawPolygonMemory.md): Draws a polygon.
