# ImageLinkGrayscaleMemory

`ImageLinkGrayscaleMemory[image]` converts a Wolfram Language `Image` object to grayscale directly in memory.

## Parameters

*   **image** (Image): The input Wolfram Language `Image` object.

## Returns

*   **Image**: A new grayscale `Image` object.

## Examples

### Convert Image Object to Grayscale

```wolfram
img = Import["ExampleData/lena.tif"];
gray = ImageLinkGrayscaleMemory[img]
```

## See Also

* [ImageLinkGrayscale](ImageLinkGrayscale.md): Converts an image file to grayscale.
* [ImageLinkInvertMemory](ImageLinkInvertMemory.md): Inverts an Image object in memory.
