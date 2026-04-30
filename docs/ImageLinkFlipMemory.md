# ImageLinkFlipMemory

`ImageLinkFlipMemory[image, direction]` flips a Wolfram Language `Image` object along the specified axis directly in memory.

## Parameters

*   **image** (Image): The input Wolfram Language `Image` object.
*   **direction** (String): The axis to flip along. Supported values:
    *   `"Horizontal"`: Flips the image left-to-right.
    *   `"Vertical"`: Flips the image top-to-bottom.

## Returns

*   **Image**: A new flipped `Image` object.

## Examples

### Flip an Image Object Horizontally

```wolfram
img = Import["ExampleData/lena.tif"];
flipped = ImageLinkFlipMemory[img, "Horizontal"]
```

## See Also

* [ImageLinkFlip](ImageLinkFlip.md): Flips an image file.
* [ImageLinkRotateMemory](ImageLinkRotateMemory.md): Rotates an Image object in memory.
