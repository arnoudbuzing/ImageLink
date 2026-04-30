# ImageLinkBlurMemory

`ImageLinkBlurMemory[image, sigma]` applies a Gaussian blur to a Wolfram Language `Image` object directly in memory and returns the result as a new `Image` object.

## Parameters

*   **image** (Image): The input Wolfram Language `Image` object.
*   **sigma** (Numeric): The standard deviation of the Gaussian kernel. Larger values produce more blur.

## Returns

*   **Image**: A new `Image` object with the blur applied.

## Examples

### Apply Blur to an Image Object

```wolfram
img = Import["ExampleData/lena.tif"];
blurred = ImageLinkBlurMemory[img, 2.0]
```

## See Also

* [ImageLinkBlur](ImageLinkBlur.md): Applies a Gaussian blur to an image file.
* [ImageLinkMedianFilterMemory](ImageLinkMedianFilterMemory.md): Applies a median filter.
