# ImageLinkMorphologyOpenMemory

`ImageLinkMorphologyOpenMemory[image, norm, k]` performs a morphological opening operation on a Wolfram Language `Image` object directly in memory.

## Parameters

*   **image** (Image): The input Wolfram Language `Image` object.
*   **norm** (Integer): The distance metric (e.g., `1` for L1). Default is `1`.
*   **k** (Integer): The size of the structuring element. Default is `1`.

## Returns

*   **Image**: A new `Image` object after opening.

## Description

Morphological opening is an erosion followed by a dilation. It is useful for removing small objects or noise from the foreground while preserving the size and shape of larger objects.

## Examples

### Apply Morphological Open

```wolfram
img = Binarize[Import["ExampleData/lena.tif"]];
opened = ImageLinkMorphologyOpenMemory[img, 1, 2]
```

## See Also

* [ImageLinkMorphologyCloseMemory](ImageLinkMorphologyCloseMemory.md): Performs morphological closing.
* [ImageLinkDilateMemory](ImageLinkDilateMemory.md): Standard dilation.
* [ImageLinkErodeMemory](ImageLinkErodeMemory.md): Standard erosion.
