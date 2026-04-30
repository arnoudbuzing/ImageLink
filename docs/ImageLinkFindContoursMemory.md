# ImageLinkFindContoursMemory

`ImageLinkFindContoursMemory[image, threshold]` detects contours in a Wolfram Language `Image` object and returns them as a structured list.

## Parameters

*   **image** (Image): The input Wolfram Language `Image` object.
*   **threshold** (Integer): The intensity threshold used to binarize the image before contour detection.

## Returns

*   **List of Associations**: A list of detected contours, where each contour is an association with the following keys:
    *   `"Points"`: A list of `{{x, y}, ...}` coordinates defining the contour.
    *   `"BorderType"`: Either `"Outer"` or `"Hole"`.
    *   `"Parent"`: The index of the parent contour (or -1 for top-level contours).

## Examples

### Detect Contours

```wolfram
img = Import["ExampleData/lena.tif"];
contours = ImageLinkFindContoursMemory[img, 128];
(* Get the number of contours *)
Length[contours]
```

### Extract Points from the First Contour

```wolfram
points = contours[[1, "Points"]];
```

## See Also

* [ImageLinkConvexHullMemory](ImageLinkConvexHullMemory.md): Computes the convex hull of points.
* [ImageLinkContourAreaMemory](ImageLinkContourAreaMemory.md): Computes the area of a contour.
