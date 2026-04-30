# ImageLinkInvertMemory

`ImageLinkInvertMemory[image]` inverts the colors of a Wolfram Language `Image` object directly in memory.

## Parameters

*   **image** (Image): The input Wolfram Language `Image` object.

## Returns

*   **Image**: A new `Image` object with inverted colors.

## Examples

### Invert an Image Object

```wolfram
img = Import["ExampleData/lena.tif"];
inverted = ImageLinkInvertMemory[img]
```

## See Also

* [ImageLinkInvert](ImageLinkInvert.md): Inverts an image file.
* [ImageLinkGrayscaleMemory](ImageLinkGrayscaleMemory.md): Converts an Image object to grayscale.
