# ImageLinkFlip

`ImageLinkFlip[input, output, direction]` flips an image file along the specified axis and saves the result.

## Parameters

*   **input** (String): The file path to the input image.
*   **output** (String): The file path where the flipped image will be saved.
*   **direction** (String): The axis to flip along. Supported values:
    *   `"Horizontal"`: Flips the image left-to-right.
    *   `"Vertical"`: Flips the image top-to-bottom.

## Examples

### Horizontal Flip

```wolfram
ImageLinkFlip["input.jpg", "flipped_h.jpg", "Horizontal"]
```

### Vertical Flip

```wolfram
ImageLinkFlip["input.jpg", "flipped_v.jpg", "Vertical"]
```

## See Also

* [ImageLinkFlipMemory](ImageLinkFlipMemory.md): Flips an Image object directly in memory.
* [ImageLinkRotate](ImageLinkRotate.md): Rotates an image file.
