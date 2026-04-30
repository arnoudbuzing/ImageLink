# ImageLinkErodeMemory

`ImageLinkErodeMemory[image, radius]` erodes a Wolfram Language `Image` object directly in memory.

## Parameters

*   **image** (Image): The input Wolfram Language `Image` object.
*   **radius** (Integer): The radius of the erosion operation.

## Returns

*   **Image**: A new eroded `Image` object.

## Examples

### Erode an Image Object

```wolfram
img = Import["ExampleData/lena.tif"];
eroded = ImageLinkErodeMemory[img, 2]
```

## See Also

* [ImageLinkDilateMemory](ImageLinkDilateMemory.md): Dilates an Image object in memory.
* [ImageLinkMorphologyCloseMemory](ImageLinkMorphologyCloseMemory.md): Performs morphological closing.
