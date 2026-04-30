# ImageLinkColorType

`ImageLinkColorType[input]` returns a string representing the color type of an image file.

## Parameters

*   **input** (String): The file path to the image.

## Returns

*   **String**: The color type (e.g., `"Rgb8"`, `"Rgba8"`, `"L8"`, `"La8"`, etc.).

## Examples

### Get Color Type

```wolfram
ImageLinkColorType["photo.jpg"]
(* "Rgb8" *)
```

```wolfram
ImageLinkColorType["transparent.png"]
(* "Rgba8" *)
```

## See Also

* [ImageLinkDimensions](ImageLinkDimensions.md): Retrieves the dimensions of an image file.
