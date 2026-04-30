# ImageLinkBlur

`ImageLinkBlur[input, output, sigma]` applies a Gaussian blur to an image file and saves the result.

## Parameters

*   **input** (String): The file path to the input image.
*   **output** (String): The file path where the blurred image will be saved.
*   **sigma** (Numeric): The standard deviation of the Gaussian kernel. Larger values produce more blur.

## Examples

### Apply Light Blur

```wolfram
ImageLinkBlur["photo.jpg", "blur_low.jpg", 1.5]
```

### Apply Heavy Blur

```wolfram
ImageLinkBlur["photo.jpg", "blur_high.jpg", 5.0]
```

## See Also

* [ImageLinkBlurMemory](ImageLinkBlurMemory.md): Blurs an Image object directly in memory.
* [ImageLinkUnsharpen](ImageLinkUnsharpen.md): Sharpens an image using an unsharp mask.
