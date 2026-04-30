# ImageLinkMatchTemplateMemory

`ImageLinkMatchTemplateMemory[image, template, method]` performs template matching on a Wolfram Language `Image` object directly in memory.

## Parameters

*   **image** (Image): The input Wolfram Language `Image` object.
*   **template** (Image): The template image to search for.
*   **method** (Integer): The matching algorithm to use:
    *   `1`: Sum of Squared Errors (SSE)
    *   `2`: SSE Normalized
    *   `3`: Cross-Correlation
    *   `4`: Cross-Correlation Normalized (**Default**)

## Returns

*   **Image**: A grayscale `Image` object where pixel values represent the matching score at each location.

## Examples

### Perform Template Matching

```wolfram
img = Import["ExampleData/lena.tif"];
template = ImageCrop[img, {50, 50}];
result = ImageLinkMatchTemplateMemory[img, template, 4];
(* Find the best match position *)
pos = FirstPosition[ImageData[result], Max[ImageData[result]]]
```

## See Also

* [ImageLinkFindContoursMemory](ImageLinkFindContoursMemory.md): Detects contours in an image.
