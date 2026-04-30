# ImageLinkDimensions

`ImageLinkDimensions[input]` returns the width and height of an image file.

## Parameters

*   **input** (String): The file path to the image.

## Returns

*   **{width, height}** (List of Integers): The dimensions of the image in pixels.

## Examples

### Get Image Dimensions

```wolfram
ImageLinkDimensions["photo.jpg"]
(* {1920, 1080} *)
```

## See Also

* [ImageLinkColorType](ImageLinkColorType.md): Retrieves the color type of an image file.
* [ImageLinkResize](ImageLinkResize.md): Resizes an image.
