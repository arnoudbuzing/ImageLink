# ImageLinkDrawTextMemory

`ImageLinkDrawTextMemory[image, text, {x, y}, scale, fontPath, color]` draws text onto a Wolfram `Image` object directly in memory.

## Parameters

*   **image** (Image): The input Wolfram `Image` object.
*   **text** (String): The text string to be drawn.
*   **{x, y}** (List of Integers): The coordinates for the top-left corner of the text placement.
*   **scale** (Number): The font scale (size).
*   **fontPath** (String): The absolute path to a TrueType (`.ttf`) or OpenType (`.otf`) font file.
*   **color** (List): A list of normalized RGB or Grayscale values (e.g., `{1, 0, 0}` for red).

## Examples

### Basic Text Annotation

Draw yellow text on an image using a system font:

```wolfram
font = "/System/Library/Fonts/Supplemental/Andale Mono.ttf";
img = ExampleData[{"TestImage", "Lena"}];

annotated = ImageLinkDrawTextMemory[img, "Lena Söderberg", {20, 20}, 32, font, {1, 1, 0}]
```

### Large Title Rendering

Draw a large red title in the center of a black background:

```wolfram
bg = Image[Table[{0, 0, 0}, {y, 400}, {x, 800}]];
font = "/System/Library/Fonts/Supplemental/Arial.ttf";

ImageLinkDrawTextMemory[bg, "IMAGE LINK", {150, 150}, 120, font, {1, 0, 0}]
```

## Remarks

*   The function requires an absolute path to the font file. On macOS, common fonts are located in `/System/Library/Fonts/` or `/Library/Fonts/`.
*   The coordinate system starts at `{0, 0}` at the top-left corner of the image.
*   This function operates directly on the image buffer in Rust and returns a new Wolfram `Image` object without any disk I/O.

## See Also

*   `ImageLinkDrawLineMemory`: Draws a line segment.
*   `ImageLinkDrawRectangleMemory`: Draws a rectangle.
*   `ImageLinkDrawCircleMemory`: Draws a circle.
