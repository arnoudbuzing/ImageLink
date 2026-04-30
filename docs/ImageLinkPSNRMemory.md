# ImageLinkPSNRMemory

`ImageLinkPSNRMemory[image1, image2]` computes the Peak Signal-to-Noise Ratio (PSNR) between two Wolfram Language `Image` objects.

## Parameters

*   **image1** (Image): The first input image.
*   **image2** (Image): The second input image (typically a distorted or compressed version of the first).

## Returns

*   **Real**: The PSNR value in decibels (dB). Higher values indicate better quality/lower distortion.

## Description

PSNR is commonly used to measure the quality of reconstruction of lossy compression codecs.

## Examples

### Compute PSNR

```wolfram
img1 = Import["ExampleData/lena.tif"];
img2 = ImageLinkBlurMemory[img1, 1.0];
psnr = ImageLinkPSNRMemory[img1, img2]
```

## See Also

* [ImageLinkPHashMemory](ImageLinkPHashMemory.md): Computes a perceptual hash.
