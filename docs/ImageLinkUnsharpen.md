# ImageLinkUnsharpen

`ImageLinkUnsharpen[input, output, sigma, threshold]` applies an unsharp mask to an image file and saves the result.

## Parameters

*   **input** (String): The file path to the input image.
*   **output** (String): The file path where the sharpened image will be saved.
*   **sigma** (Numeric): The standard deviation of the Gaussian blur used for the unsharp mask.
*   **threshold** (Integer): The minimum brightness change required for a pixel to be sharpened.

## Examples

### Sharpen Image

```wolfram
ImageLinkUnsharpen["blurry.jpg", "sharpened.jpg", 1.0, 5]
```

## See Also

* [ImageLinkUnsharpenMemory](ImageLinkUnsharpenMemory.md): Sharpens an Image object directly in memory.
* [ImageLinkBlur](ImageLinkBlur.md): Applies a Gaussian blur.
