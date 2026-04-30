# ImageLinkFloodFillMemory

`ImageLinkFloodFillMemory[image, {x, y}, color]` performs a flood fill operation on a Wolfram Language `Image` object directly in memory, starting from the specified seed point.

## Parameters

*   **image** (Image): The input Wolfram Language `Image` object.
*   **{x, y}** (List of Integers): The seed point coordinates.
*   **color** (List): A list of numeric values (0 to 1) representing the fill color.

## Returns

*   **Image**: The `Image` object with the region filled.

## Description

The function fills a connected region of pixels starting from `{x, y}` that have the same color as the seed point.

## Examples

### Perform Flood Fill

```wolfram
img = Import["ExampleData/lena.tif"];
(* Fill a part of the background starting at {10, 10} *)
filled = ImageLinkFloodFillMemory[img, {10, 10}, {0, 1, 0}]
```

## See Also

* [ImageLinkDrawPolygonMemory](ImageLinkDrawPolygonMemory.md): Draws a filled or outlined polygon.
* [ImageLinkConnectedComponentsMemory](ImageLinkConnectedComponentsMemory.md): Labels connected regions.
