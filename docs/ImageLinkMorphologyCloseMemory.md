# ImageLinkMorphologyCloseMemory

`ImageLinkMorphologyCloseMemory[image, norm, k]` performs a morphological closing operation on a Wolfram Language `Image` object directly in memory.

## Parameters

*   **image** (Image): The input Wolfram Language `Image` object.
*   **norm** (Integer): The distance metric (e.g., `1` for L1). Default is `1`.
*   **k** (Integer): The size of the structuring element. Default is `1`.

## Returns

*   **Image**: A new `Image` object after closing.

## Description

Morphological closing is a dilation followed by an erosion. It is useful for closing small holes or gaps within foreground objects.

## Examples

### Apply Morphological Close

```wolfram
img = Binarize[Import["ExampleData/lena.tif"]];
closed = ImageLinkMorphologyCloseMemory[img, 1, 2]
```

## See Also

* [ImageLinkMorphologyOpenMemory](ImageLinkMorphologyOpenMemory.md): Performs morphological opening.
* [ImageLinkDilateMemory](ImageLinkDilateMemory.md): Standard dilation.
* [ImageLinkErodeMemory](ImageLinkErodeMemory.md): Standard erosion.
