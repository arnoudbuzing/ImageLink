# ImageLinkResize

`ImageLinkResize[input, output, {width, height}]` resizes an image file and saves the result to a new file.

## Parameters

*   **input** (String): The file path to the input image.
*   **output** (String): The file path where the resized image will be saved.
*   **{width, height}** (List of Integers): The target dimensions for the resized image.

## Options

### Method

The `Method` option specifies the interpolation algorithm used for resizing.

| Value | Description |
| :--- | :--- |
| `"Nearest"` | Nearest neighbor interpolation. Fastest but lowest quality. |
| `"Triangle"` | Bilinear interpolation. Balanced speed and quality. (**Default**) |
| `"CatmullRom"` | Catmull-Rom cubic interpolation. |
| `"Gaussian"` | Gaussian interpolation. |
| `"Lanczos3"` | Lanczos interpolation with a window size of 3. High quality. |

## Examples

### Basic Resizing

Resize an image to 800x600 pixels using the default method:

```wolfram
ImageLinkResize["input.jpg", "output.jpg", {800, 600}]
```

### High Quality Resizing

Resize an image using the Lanczos3 method for better results:

```wolfram
ImageLinkResize["photo.png", "photo_large.png", {1920, 1080}, Method -> "Lanczos3"]
```

### Nearest Neighbor for Pixel Art

Use the `"Nearest"` method to preserve sharp edges when resizing pixel art:

```wolfram
ImageLinkResize["sprite.png", "sprite_scaled.png", {256, 256}, Method -> "Nearest"]
```

## See Also

*   `ImageLinkResizeMemory`: Resizes an Image object directly in memory.
*   `ImageLinkDimensions`: Retrieves the dimensions of an image file.
