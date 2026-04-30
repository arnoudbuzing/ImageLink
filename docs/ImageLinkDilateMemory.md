# ImageLinkDilateMemory

`ImageLinkDilateMemory[image, radius]` dilates a Wolfram Language `Image` object directly in memory.

## Parameters

*   **image** (Image): The input Wolfram Language `Image` object.
*   **radius** (Integer): The radius of the dilation operation.

## Returns

*   **Image**: A new dilated `Image` object.

## Examples

### Dilate an Image Object

```wolfram
img = Import["ExampleData/lena.tif"];
dilated = ImageLinkDilateMemory[img, 2]
```

## See Also

* [ImageLinkErodeMemory](ImageLinkErodeMemory.md): Erodes an Image object in memory.
* [ImageLinkMorphologyOpenMemory](ImageLinkMorphologyOpenMemory.md): Performs morphological opening.
