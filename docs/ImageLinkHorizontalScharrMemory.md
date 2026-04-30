# ImageLinkHorizontalScharrMemory

`ImageLinkHorizontalScharrMemory[image]` computes the horizontal Scharr gradient of a Wolfram `Image` object.

## Parameters

*   **image** (Image): The input Wolfram `Image` object.

## Output

Returns a 2D `List` of `Integer16` values representing the horizontal gradient of the image.

## Examples

### Computing the Horizontal Gradient

Compute the horizontal Scharr gradient for a test image:

```wolfram
img = ExampleData[{"TestImage", "Lena"}];
gradH = ImageLinkHorizontalScharrMemory[img];
```

### Visualizing the Gradient

Since the output is a list of integers (which can be negative), you can visualize it by converting it back to an image after normalization:

```wolfram
Image[gradH // Rescale]
```

## Remarks

*   **Scharr Operator**: The Scharr operator is used for edge detection and is a more rotationally symmetric alternative to the Sobel operator.
*   **Precision**: The output uses signed `Integer16` values to preserve the direction and magnitude of the gradient accurately.
*   **Performance**: Implementation is powered by the Rust `imageproc` crate for high-speed processing.

## See Also

*   `ImageLinkVerticalScharrMemory`: Computes the vertical Scharr gradient.
*   `ImageLinkHorizontalSobelMemory`: Computes the horizontal Sobel gradient.
*   `ImageLinkHorizontalPrewittMemory`: Computes the horizontal Prewitt gradient.
