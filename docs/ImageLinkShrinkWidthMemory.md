# ImageLinkShrinkWidthMemory

`ImageLinkShrinkWidthMemory[image, targetWidth]` reduces the width of a Wolfram Language `Image` object using seam carving (content-aware resizing).

## Parameters

*   **image** (Image): The input Wolfram Language `Image` object.
*   **targetWidth** (Integer): The desired width in pixels. Must be less than or equal to the current image width.

## Returns

*   **Image**: A new `Image` object with the reduced width.

## Description

Seam carving identifies "low energy" paths (seams) through the image and removes them, preserving high-energy features like edges and textures.

## Examples

### Content-Aware Width Reduction

```wolfram
img = Import["ExampleData/lena.tif"];
(* Lena image is 512x512 *)
shrunk = ImageLinkShrinkWidthMemory[img, 400]
```

## See Also

* [ImageLinkResizeMemory](ImageLinkResizeMemory.md): Standard interpolation-based resizing.
* [ImageLinkCropMemory](ImageLinkCropMemory.md): Standard rectangular cropping.
