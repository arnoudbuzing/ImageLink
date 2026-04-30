# ImageLinkUnsharpenMemory

`ImageLinkUnsharpenMemory[image, sigma, threshold]` applies an unsharp mask to a Wolfram Language `Image` object directly in memory.

## Parameters

*   **image** (Image): The input Wolfram Language `Image` object.
*   **sigma** (Numeric): The standard deviation of the Gaussian blur used for the unsharp mask.
*   **threshold** (Integer): The minimum brightness change required for a pixel to be sharpened.

## Returns

*   **Image**: A new `Image` object with the sharpening applied.

## Examples

### Sharpen an Image Object

```wolfram
img = Import["ExampleData/lena.tif"];
sharpened = ImageLinkUnsharpenMemory[img, 1.5, 3]
```

## See Also

* [ImageLinkUnsharpen](ImageLinkUnsharpen.md): Sharpens an image file.
* [ImageLinkBlurMemory](ImageLinkBlurMemory.md): Applies a Gaussian blur.
