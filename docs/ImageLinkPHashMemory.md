# ImageLinkPHashMemory

`ImageLinkPHashMemory[image]` computes a 64-bit perceptual hash (pHash) of a Wolfram Language `Image` object directly in memory.

## Parameters

*   **image** (Image): The input Wolfram Language `Image` object.

## Returns

*   **Integer**: A 64-bit integer representing the perceptual hash.

## Description

Perceptual hashing is a technique used to identify duplicate or similar images. Unlike cryptographic hashes, perceptual hashes of similar images are themselves similar (low Hamming distance).

## Examples

### Compute pHash

```wolfram
img = Import["ExampleData/lena.tif"];
hash = ImageLinkPHashMemory[img]
(* 13546782348574635241 *)
```

### Check Similarity

```wolfram
img1 = Import["ExampleData/lena.tif"];
img2 = ImageLinkResizeMemory[img1, {100, 100}];
hash1 = ImageLinkPHashMemory[img1];
hash2 = ImageLinkPHashMemory[img2];
(* Compare bits to find similarity *)
bitDistance = HammingDistance[IntegerDigits[hash1, 2, 64], IntegerDigits[hash2, 2, 64]]
```

## See Also

* [ImageLinkPSNRMemory](ImageLinkPSNRMemory.md): Measures image quality.
