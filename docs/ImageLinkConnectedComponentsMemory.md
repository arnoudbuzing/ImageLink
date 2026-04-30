# ImageLinkConnectedComponentsMemory

`ImageLinkConnectedComponentsMemory[image, connectivity]` labels connected components in a binary Wolfram Language `Image` object directly in memory.

## Parameters

*   **image** (Image): The input binary Wolfram Language `Image` object.
*   **connectivity** (Integer): The pixel connectivity to use (either `4` or `8`). Default is `8`.

## Returns

*   **Image**: A 32-bit `Image` object where each pixel value represents the label of the component it belongs to (0 for background).

## Examples

### Label Connected Components

```wolfram
img = Binarize[Import["ExampleData/lena.tif"]];
labels = ImageLinkConnectedComponentsMemory[img, 8];
(* Colorize the labels for visualization *)
Colorize[labels]
```

## See Also

* [ImageLinkFindContoursMemory](ImageLinkFindContoursMemory.md): Detects contours in an image.
* [ImageLinkFloodFillMemory](ImageLinkFloodFillMemory.md): Fills a connected region.
