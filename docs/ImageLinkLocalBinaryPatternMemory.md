# ImageLinkLocalBinaryPatternMemory

`ImageLinkLocalBinaryPatternMemory[image]` computes the Local Binary Pattern (LBP) image of a Wolfram Language `Image` object directly in memory.

## Parameters

*   **image** (Image): The input Wolfram Language `Image` object.

## Returns

*   **Image**: A grayscale `Image` object representing the local texture of the input.

## Description

Local Binary Patterns are used for texture classification and face recognition.

## Examples

### Compute LBP Image

```wolfram
img = Import["ExampleData/lena.tif"];
lbp = ImageLinkLocalBinaryPatternMemory[img]
```

## See Also

* [ImageLinkHogMemory](ImageLinkHogMemory.md): Computes HOG descriptors.
