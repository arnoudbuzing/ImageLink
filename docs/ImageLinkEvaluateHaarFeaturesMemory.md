# ImageLinkEvaluateHaarFeaturesMemory

`ImageLinkEvaluateHaarFeaturesMemory[image, frameWidth, frameHeight]` evaluates Haar-like features on a Wolfram Language `Image` object directly in memory.

## Parameters

*   **image** (Image): The input Wolfram Language `Image` object.
*   **frameWidth** (Integer): The width of the feature frame.
*   **frameHeight** (Integer): The height of the feature frame.

## Returns

*   **List of Integers**: A list of evaluated feature values for the given frame size.

## Description

Haar-like features are commonly used in object detection (e.g., the Viola-Jones face detector).

## Examples

### Evaluate Haar Features

```wolfram
img = Import["ExampleData/lena.tif"];
features = ImageLinkEvaluateHaarFeaturesMemory[img, 24, 24];
Length[features]
```

## See Also

* [ImageLinkIntegralImageMemory](ImageLinkIntegralImageMemory.md): Computes the integral image used for fast feature evaluation.
