BeginPackage["ArnoudBuzing`ImageLink`"]

ImageLinkVersion::usage = "ImageLinkVersion[] returns the version string of the Rust library."
ImageLinkResize::usage = "ImageLinkResize[input, output, {width, height}, Method -> \"Triangle\"] resizes an image and saves it."
ImageLinkFlip::usage = "ImageLinkFlip[input, output, direction] flips an image. direction can be \"Horizontal\" or \"Vertical\"."
ImageLinkRotate::usage = "ImageLinkRotate[input, output, angle] rotates an image. angle can be 90, 180, or 270."
ImageLinkCrop::usage = "ImageLinkCrop[input, output, {x, y, w, h}] crops an image."
ImageLinkGrayscale::usage = "ImageLinkGrayscale[input, output] converts an image to grayscale."
ImageLinkInvert::usage = "ImageLinkInvert[input, output] inverts the colors of an image."
ImageLinkBlur::usage = "ImageLinkBlur[input, output, sigma] applies a Gaussian blur with the specified sigma."
ImageLinkUnsharpen::usage = "ImageLinkUnsharpen[input, output, sigma, threshold] applies an unsharp mask."
ImageLinkDimensions::usage = "ImageLinkDimensions[input] returns the dimensions {width, height} of an image."
ImageLinkColorType::usage = "ImageLinkColorType[input] returns the color type of an image."
ImageLinkBlurMemory::usage = "ImageLinkBlurMemory[image, sigma] applies a Gaussian blur to an Image object directly in memory."
ImageLinkInvertMemory::usage = "ImageLinkInvertMemory[image] inverts colors of an Image object directly in memory."
ImageLinkUnsharpenMemory::usage = "ImageLinkUnsharpenMemory[image, sigma, threshold] applies an unsharp mask to an Image object directly in memory."
ImageLinkFlipMemory::usage = "ImageLinkFlipMemory[image, direction] flips an Image object directly in memory. direction can be \"Horizontal\" or \"Vertical\"."
ImageLinkRotateMemory::usage = "ImageLinkRotateMemory[image, angle] rotates an Image object directly in memory. angle can be 90, 180, or 270."
ImageLinkGrayscaleMemory::usage = "ImageLinkGrayscaleMemory[image] converts an Image object to grayscale directly in memory."
ImageLinkCropMemory::usage = "ImageLinkCropMemory[image, {x, y, w, h}] crops an Image object directly in memory."
ImageLinkResizeMemory::usage = "ImageLinkResizeMemory[image, {width, height}, Method -> \"Triangle\"] resizes an Image object directly in memory."
ImageLinkCannyMemory::usage = "ImageLinkCannyMemory[image, low, high] applies Canny edge detection directly in memory."
ImageLinkDilateMemory::usage = "ImageLinkDilateMemory[image, radius] dilates an Image object directly in memory."
ImageLinkErodeMemory::usage = "ImageLinkErodeMemory[image, radius] erodes an Image object directly in memory."
ImageLinkMedianFilterMemory::usage = "ImageLinkMedianFilterMemory[image, xRadius, yRadius] applies a median filter to an Image object directly in memory."
ImageLinkFilter3x3Memory::usage = "ImageLinkFilter3x3Memory[image, kernel] applies a 3x3 custom convolution kernel to an Image object directly in memory."
ImageLinkEqualizeHistogramMemory::usage = "ImageLinkEqualizeHistogramMemory[image] equalizes the histogram of an Image object directly in memory."
ImageLinkAdaptiveThresholdMemory::usage = "ImageLinkAdaptiveThresholdMemory[image, blockRadius, delta] applies an adaptive threshold directly in memory."
ImageLinkDrawLineMemory::usage = "ImageLinkDrawLineMemory[image, {x1, y1}, {x2, y2}, color] draws a line segment directly in memory."
ImageLinkDrawRectangleMemory::usage = "ImageLinkDrawRectangleMemory[image, {x, y, w, h}, color, Filled -> False] draws a rectangle directly in memory."
ImageLinkDrawCircleMemory::usage = "ImageLinkDrawCircleMemory[image, {x, y}, radius, color, Filled -> False] draws a circle directly in memory."
ImageLinkDrawEllipseMemory::usage = "ImageLinkDrawEllipseMemory[image, {x, y}, {rx, ry}, color, Filled -> False] draws an ellipse directly in memory."
ImageLinkDrawPolygonMemory::usage = "ImageLinkDrawPolygonMemory[image, {{x1,y1}, {x2,y2}, ...}, color, Filled -> False] draws a polygon directly in memory."
ImageLinkShrinkWidthMemory::usage = "ImageLinkShrinkWidthMemory[image, targetWidth] applies seam carving to shrink the image to the target width directly in memory."
ImageLinkDrawTextMemory::usage = "ImageLinkDrawTextMemory[image, text, {x, y}, scale, fontPath, color] draws text directly in memory."
ImageLinkFloodFillMemory::usage = "ImageLinkFloodFillMemory[image, {x, y}, color] performs a flood fill directly in memory."
ImageLinkDrawAntialiasedLineMemory::usage = "ImageLinkDrawAntialiasedLineMemory[image, {x1, y1}, {x2, y2}, color] draws an anti-aliased line segment directly in memory."
ImageLinkDrawBezierMemory::usage = "ImageLinkDrawBezierMemory[image, {p1, p2, p3, p4}, color] draws a cubic Bezier curve directly in memory."

Begin["`Private`"]

$LibraryFile = FileNameJoin[{DirectoryName[$InputFileName], "LibraryResources", $SystemID, "librust.dylib"}];

imageLinkVersionFunc = LibraryFunctionLoad[$LibraryFile, "get_version", {}, "UTF8String"];
imageLinkResizeFunc = LibraryFunctionLoad[$LibraryFile, "resize_image", {"UTF8String", "UTF8String", Integer, Integer, "UTF8String"}, "UTF8String"];
imageLinkFlipFunc = LibraryFunctionLoad[$LibraryFile, "flip_image", {"UTF8String", "UTF8String", "UTF8String"}, "UTF8String"];
imageLinkRotateFunc = LibraryFunctionLoad[$LibraryFile, "rotate_image", {"UTF8String", "UTF8String", Integer}, "UTF8String"];
imageLinkCropFunc = LibraryFunctionLoad[$LibraryFile, "crop_image", {"UTF8String", "UTF8String", Integer, Integer, Integer, Integer}, "UTF8String"];
imageLinkGrayscaleFunc = LibraryFunctionLoad[$LibraryFile, "grayscale_image", {"UTF8String", "UTF8String"}, "UTF8String"];
imageLinkInvertFunc = LibraryFunctionLoad[$LibraryFile, "invert_image", {"UTF8String", "UTF8String"}, "UTF8String"];
imageLinkBlurFunc = LibraryFunctionLoad[$LibraryFile, "blur_image", {"UTF8String", "UTF8String", Real}, "UTF8String"];
imageLinkUnsharpenFunc = LibraryFunctionLoad[$LibraryFile, "unsharpen_image", {"UTF8String", "UTF8String", Real, Integer}, "UTF8String"];
imageLinkDimensionsFunc = LibraryFunctionLoad[$LibraryFile, "image_dimensions", {"UTF8String"}, "UTF8String"];
imageLinkColorTypeFunc = LibraryFunctionLoad[$LibraryFile, "image_color_type", {"UTF8String"}, "UTF8String"];
imageLinkBlurMemoryFunc = LibraryFunctionLoad[$LibraryFile, "blur_memory", {{LibraryDataType[NumericArray, "UnsignedInteger8"]}, Real}, LibraryDataType[NumericArray, "UnsignedInteger8"]];
imageLinkInvertMemoryFunc = LibraryFunctionLoad[$LibraryFile, "invert_memory", {{LibraryDataType[NumericArray, "UnsignedInteger8"]}}, LibraryDataType[NumericArray, "UnsignedInteger8"]];
imageLinkUnsharpenMemoryFunc = LibraryFunctionLoad[$LibraryFile, "unsharpen_memory", {{LibraryDataType[NumericArray, "UnsignedInteger8"]}, Real, Integer}, LibraryDataType[NumericArray, "UnsignedInteger8"]];
imageLinkFlipMemoryFunc = LibraryFunctionLoad[$LibraryFile, "flip_memory", {{LibraryDataType[NumericArray, "UnsignedInteger8"]}, "UTF8String"}, LibraryDataType[NumericArray, "UnsignedInteger8"]];
imageLinkRotateMemoryFunc = LibraryFunctionLoad[$LibraryFile, "rotate_memory", {{LibraryDataType[NumericArray, "UnsignedInteger8"]}, Integer}, LibraryDataType[NumericArray, "UnsignedInteger8"]];
imageLinkGrayscaleMemoryFunc = LibraryFunctionLoad[$LibraryFile, "grayscale_memory", {{LibraryDataType[NumericArray, "UnsignedInteger8"]}}, LibraryDataType[NumericArray, "UnsignedInteger8"]];
imageLinkCropMemoryFunc = LibraryFunctionLoad[$LibraryFile, "crop_memory", {{LibraryDataType[NumericArray, "UnsignedInteger8"]}, Integer, Integer, Integer, Integer}, LibraryDataType[NumericArray, "UnsignedInteger8"]];
imageLinkResizeMemoryFunc = LibraryFunctionLoad[$LibraryFile, "resize_memory", {{LibraryDataType[NumericArray, "UnsignedInteger8"]}, Integer, Integer, "UTF8String"}, LibraryDataType[NumericArray, "UnsignedInteger8"]];
imageLinkCannyMemoryFunc = LibraryFunctionLoad[$LibraryFile, "canny_memory", {{LibraryDataType[NumericArray, "UnsignedInteger8"]}, Real, Real}, LibraryDataType[NumericArray, "UnsignedInteger8"]];
imageLinkDilateMemoryFunc = LibraryFunctionLoad[$LibraryFile, "dilate_memory", {{LibraryDataType[NumericArray, "UnsignedInteger8"]}, Integer}, LibraryDataType[NumericArray, "UnsignedInteger8"]];
imageLinkErodeMemoryFunc = LibraryFunctionLoad[$LibraryFile, "erode_memory", {{LibraryDataType[NumericArray, "UnsignedInteger8"]}, Integer}, LibraryDataType[NumericArray, "UnsignedInteger8"]];
imageLinkMedianFilterMemoryFunc = LibraryFunctionLoad[$LibraryFile, "median_memory", {{LibraryDataType[NumericArray, "UnsignedInteger8"]}, Integer, Integer}, LibraryDataType[NumericArray, "UnsignedInteger8"]];
imageLinkFilter3x3MemoryFunc = LibraryFunctionLoad[$LibraryFile, "filter3x3_memory", {{LibraryDataType[NumericArray, "UnsignedInteger8"]}, {LibraryDataType[NumericArray, "Real64"]}}, LibraryDataType[NumericArray, "UnsignedInteger8"]];
imageLinkEqualizeHistogramMemoryFunc = LibraryFunctionLoad[$LibraryFile, "equalize_memory", {{LibraryDataType[NumericArray, "UnsignedInteger8"]}}, LibraryDataType[NumericArray, "UnsignedInteger8"]];
imageLinkAdaptiveThresholdMemoryFunc = LibraryFunctionLoad[$LibraryFile, "adaptive_threshold_memory", {{LibraryDataType[NumericArray, "UnsignedInteger8"]}, Integer, Integer}, LibraryDataType[NumericArray, "UnsignedInteger8"]];
imageLinkDrawLineMemoryFunc = LibraryFunctionLoad[$LibraryFile, "draw_line_memory", {{LibraryDataType[NumericArray, "UnsignedInteger8"]}, Real, Real, Real, Real, {LibraryDataType[NumericArray, "UnsignedInteger8"]}}, LibraryDataType[NumericArray, "UnsignedInteger8"]];
imageLinkDrawRectMemoryFunc = LibraryFunctionLoad[$LibraryFile, "draw_rect_memory", {{LibraryDataType[NumericArray, "UnsignedInteger8"]}, Integer, Integer, Integer, Integer, {LibraryDataType[NumericArray, "UnsignedInteger8"]}, True|False}, LibraryDataType[NumericArray, "UnsignedInteger8"]];
imageLinkDrawCircleMemoryFunc = LibraryFunctionLoad[$LibraryFile, "draw_circle_memory", {{LibraryDataType[NumericArray, "UnsignedInteger8"]}, Integer, Integer, Integer, {LibraryDataType[NumericArray, "UnsignedInteger8"]}, True|False}, LibraryDataType[NumericArray, "UnsignedInteger8"]];
imageLinkDrawEllipseMemoryFunc = LibraryFunctionLoad[$LibraryFile, "draw_ellipse_memory", {{LibraryDataType[NumericArray, "UnsignedInteger8"]}, Integer, Integer, Integer, Integer, {LibraryDataType[NumericArray, "UnsignedInteger8"]}, True|False}, LibraryDataType[NumericArray, "UnsignedInteger8"]];
imageLinkDrawPolygonMemoryFunc = LibraryFunctionLoad[$LibraryFile, "draw_polygon_memory", {{LibraryDataType[NumericArray, "UnsignedInteger8"]}, {LibraryDataType[NumericArray, "Integer64"]}, {LibraryDataType[NumericArray, "Integer64"]}, {LibraryDataType[NumericArray, "UnsignedInteger8"]}, True|False}, LibraryDataType[NumericArray, "UnsignedInteger8"]];
imageLinkShrinkWidthMemoryFunc = LibraryFunctionLoad[$LibraryFile, "shrink_width_memory", {{LibraryDataType[NumericArray, "UnsignedInteger8"]}, Integer}, LibraryDataType[NumericArray, "UnsignedInteger8"]];
imageLinkDrawTextMemoryFunc = LibraryFunctionLoad[$LibraryFile, "draw_text_memory", {{LibraryDataType[NumericArray, "UnsignedInteger8"]}, Integer, Integer, Real, "UTF8String", "UTF8String", {LibraryDataType[NumericArray, "UnsignedInteger8"]}}, LibraryDataType[NumericArray, "UnsignedInteger8"]];
imageLinkFloodFillMemoryFunc = LibraryFunctionLoad[$LibraryFile, "flood_fill_memory", {{LibraryDataType[NumericArray, "UnsignedInteger8"]}, Integer, Integer, {LibraryDataType[NumericArray, "UnsignedInteger8"]}}, LibraryDataType[NumericArray, "UnsignedInteger8"]];
imageLinkDrawAALineMemoryFunc = LibraryFunctionLoad[$LibraryFile, "draw_antialiased_line_memory", {{LibraryDataType[NumericArray, "UnsignedInteger8"]}, Integer, Integer, Integer, Integer, {LibraryDataType[NumericArray, "UnsignedInteger8"]}}, LibraryDataType[NumericArray, "UnsignedInteger8"]];
imageLinkDrawBezierMemoryFunc = LibraryFunctionLoad[$LibraryFile, "draw_bezier_memory", {{LibraryDataType[NumericArray, "UnsignedInteger8"]}, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer, {LibraryDataType[NumericArray, "UnsignedInteger8"]}}, LibraryDataType[NumericArray, "UnsignedInteger8"]];

ImageLinkVersion[] := imageLinkVersionFunc[]

Options[ImageLinkResize] = {Method -> "Triangle"}
Options[ImageLinkResizeMemory] = {Method -> "Triangle"}
Options[ImageLinkDrawRectangleMemory] = {Filled -> False}
Options[ImageLinkDrawCircleMemory] = {Filled -> False}
Options[ImageLinkDrawEllipseMemory] = {Filled -> False}
Options[ImageLinkDrawPolygonMemory] = {Filled -> False}

ImageLinkResize[input_String, output_String, {width_Integer, height_Integer}, OptionsPattern[]] := Module[{method},
  method = OptionValue[Method];
  imageLinkResizeFunc[ExpandFileName[input], ExpandFileName[output], width, height, method]
]

ImageLinkFlip[input_String, output_String, direction_String] := 
  imageLinkFlipFunc[ExpandFileName[input], ExpandFileName[output], direction]

ImageLinkRotate[input_String, output_String, angle_Integer] := 
  imageLinkRotateFunc[ExpandFileName[input], ExpandFileName[output], angle]

ImageLinkCrop[input_String, output_String, {x_Integer, y_Integer, w_Integer, h_Integer}] := 
  imageLinkCropFunc[ExpandFileName[input], ExpandFileName[output], x, y, w, h]

ImageLinkGrayscale[input_String, output_String] := 
  imageLinkGrayscaleFunc[ExpandFileName[input], ExpandFileName[output]]

ImageLinkInvert[input_String, output_String] := 
  imageLinkInvertFunc[ExpandFileName[input], ExpandFileName[output]]

ImageLinkBlur[input_String, output_String, sigma_?NumericQ] := 
  imageLinkBlurFunc[ExpandFileName[input], ExpandFileName[output], N[sigma]]

ImageLinkUnsharpen[input_String, output_String, sigma_?NumericQ, threshold_Integer] := 
  imageLinkUnsharpenFunc[ExpandFileName[input], ExpandFileName[output], N[sigma], threshold]

ImageLinkDimensions[input_String] := Module[{res},
  res = imageLinkDimensionsFunc[ExpandFileName[input]];
  If[StringContainsQ[res, "Error"],
    Message[ImageLinkDimensions::error, res]; $Failed,
    ToExpression["{" <> res <> "}"]
  ]
]

ImageLinkColorType[input_String] := imageLinkColorTypeFunc[ExpandFileName[input]]

ImageLinkBlurMemory[img_Image, sigma_?NumericQ] := Module[
  {na, res1d, dims},
  na = NumericArray[ImageData[img, "Byte"], "UnsignedInteger8"];
  dims = Dimensions[na];
  res1d = imageLinkBlurMemoryFunc[na, N[sigma]];
  Image[NumericArray[ArrayReshape[Normal[res1d], dims], "UnsignedInteger8"], "Byte", ColorSpace -> ImageColorSpace[img]]
]

ImageLinkInvertMemory[img_Image] := Module[
  {na, res1d, dims},
  na = NumericArray[ImageData[img, "Byte"], "UnsignedInteger8"];
  dims = Dimensions[na];
  res1d = imageLinkInvertMemoryFunc[na];
  Image[NumericArray[ArrayReshape[Normal[res1d], dims], "UnsignedInteger8"], "Byte", ColorSpace -> ImageColorSpace[img]]
]

ImageLinkUnsharpenMemory[img_Image, sigma_?NumericQ, threshold_Integer] := Module[
  {na, res1d, dims},
  na = NumericArray[ImageData[img, "Byte"], "UnsignedInteger8"];
  dims = Dimensions[na];
  res1d = imageLinkUnsharpenMemoryFunc[na, N[sigma], threshold];
  Image[NumericArray[ArrayReshape[Normal[res1d], dims], "UnsignedInteger8"], "Byte", ColorSpace -> ImageColorSpace[img]]
]

ImageLinkFlipMemory[img_Image, direction_String] := Module[
  {na, res1d, dims},
  na = NumericArray[ImageData[img, "Byte"], "UnsignedInteger8"];
  dims = Dimensions[na];
  res1d = imageLinkFlipMemoryFunc[na, direction];
  Image[NumericArray[ArrayReshape[Normal[res1d], dims], "UnsignedInteger8"], "Byte", ColorSpace -> ImageColorSpace[img]]
]

ImageLinkRotateMemory[img_Image, angle_Integer] := Module[
  {na, res1d, dims, newDims},
  na = NumericArray[ImageData[img, "Byte"], "UnsignedInteger8"];
  dims = Dimensions[na];
  res1d = imageLinkRotateMemoryFunc[na, angle];
  
  newDims = If[angle == 90 || angle == 270,
    {dims[[2]], dims[[1]], dims[[3]]},
    dims
  ];
  
  Image[NumericArray[ArrayReshape[Normal[res1d], newDims], "UnsignedInteger8"], "Byte", ColorSpace -> ImageColorSpace[img]]
]

ImageLinkGrayscaleMemory[img_Image] := Module[
  {na, res1d, dims, newDims},
  na = NumericArray[ImageData[img, "Byte"], "UnsignedInteger8"];
  dims = Dimensions[na];
  res1d = imageLinkGrayscaleMemoryFunc[na];
  
  newDims = {dims[[1]], dims[[2]], 1};
  
  Image[NumericArray[ArrayReshape[Normal[res1d], newDims], "UnsignedInteger8"], "Byte", ColorSpace -> "Grayscale"]
]

ImageLinkCropMemory[img_Image, {x_Integer, y_Integer, w_Integer, h_Integer}] := Module[
  {na, res1d, dims, newDims},
  na = NumericArray[ImageData[img, "Byte"], "UnsignedInteger8"];
  dims = Dimensions[na];
  res1d = imageLinkCropMemoryFunc[na, x, y, w, h];
  
  newDims = {h, w, dims[[3]]};
  
  Image[NumericArray[ArrayReshape[Normal[res1d], newDims], "UnsignedInteger8"], "Byte", ColorSpace -> ImageColorSpace[img]]
]

ImageLinkResizeMemory[img_Image, {width_Integer, height_Integer}, OptionsPattern[]] := Module[
  {na, res1d, dims, newDims, method},
  method = OptionValue[Method];
  na = NumericArray[ImageData[img, "Byte"], "UnsignedInteger8"];
  dims = Dimensions[na];
  res1d = imageLinkResizeMemoryFunc[na, width, height, method];
  
  newDims = {height, width, dims[[3]]};
  
  Image[NumericArray[ArrayReshape[Normal[res1d], newDims], "UnsignedInteger8"], "Byte", ColorSpace -> ImageColorSpace[img]]
]

ImageLinkCannyMemory[img_Image, low_?NumericQ, high_?NumericQ] := Module[
  {na, res1d, dims, newDims},
  na = NumericArray[ImageData[img, "Byte"], "UnsignedInteger8"];
  dims = Dimensions[na];
  res1d = imageLinkCannyMemoryFunc[na, N[low], N[high]];
  
  newDims = {dims[[1]], dims[[2]], 1};
  
  Image[NumericArray[ArrayReshape[Normal[res1d], newDims], "UnsignedInteger8"], "Byte", ColorSpace -> "Grayscale"]
]

ImageLinkDilateMemory[img_Image, radius_Integer] := Module[
  {na, res1d, dims},
  na = NumericArray[ImageData[img, "Byte"], "UnsignedInteger8"];
  dims = Dimensions[na];
  res1d = imageLinkDilateMemoryFunc[na, radius];
  
  Image[NumericArray[ArrayReshape[Normal[res1d], dims], "UnsignedInteger8"], "Byte", ColorSpace -> ImageColorSpace[img]]
]

ImageLinkErodeMemory[img_Image, radius_Integer] := Module[
  {na, res1d, dims},
  na = NumericArray[ImageData[img, "Byte"], "UnsignedInteger8"];
  dims = Dimensions[na];
  res1d = imageLinkErodeMemoryFunc[na, radius];
  
  Image[NumericArray[ArrayReshape[Normal[res1d], dims], "UnsignedInteger8"], "Byte", ColorSpace -> ImageColorSpace[img]]
]

ImageLinkMedianFilterMemory[img_Image, xRadius_Integer, yRadius_Integer] := Module[
  {na, res1d, dims},
  na = NumericArray[ImageData[img, "Byte"], "UnsignedInteger8"];
  dims = Dimensions[na];
  res1d = imageLinkMedianFilterMemoryFunc[na, xRadius, yRadius];
  
  Image[NumericArray[ArrayReshape[Normal[res1d], dims], "UnsignedInteger8"], "Byte", ColorSpace -> ImageColorSpace[img]]
]

ImageLinkFilter3x3Memory[img_Image, kernel_?MatrixQ] := Module[
  {na, res1d, dims, kernelNA},
  na = NumericArray[ImageData[img, "Byte"], "UnsignedInteger8"];
  dims = Dimensions[na];
  kernelNA = NumericArray[Flatten[N[kernel]], "Real64"];
  res1d = imageLinkFilter3x3MemoryFunc[na, kernelNA];
  
  Image[NumericArray[ArrayReshape[Normal[res1d], dims], "UnsignedInteger8"], "Byte", ColorSpace -> ImageColorSpace[img]]
]

ImageLinkEqualizeHistogramMemory[img_Image] := Module[
  {na, res1d, dims},
  na = NumericArray[ImageData[img, "Byte"], "UnsignedInteger8"];
  dims = Dimensions[na];
  res1d = imageLinkEqualizeHistogramMemoryFunc[na];
  
  Image[NumericArray[ArrayReshape[Normal[res1d], dims], "UnsignedInteger8"], "Byte", ColorSpace -> ImageColorSpace[img]]
]

ImageLinkAdaptiveThresholdMemory[img_Image, blockRadius_Integer, delta_Integer] := Module[
  {na, res1d, dims, newDims},
  na = NumericArray[ImageData[img, "Byte"], "UnsignedInteger8"];
  dims = Dimensions[na];
  res1d = imageLinkAdaptiveThresholdMemoryFunc[na, blockRadius, delta];
  
  newDims = {dims[[1]], dims[[2]], 1};
  
  Image[NumericArray[ArrayReshape[Normal[res1d], newDims], "UnsignedInteger8"], "Byte", ColorSpace -> "Grayscale"]
]

ImageLinkDrawLineMemory[img_Image, {x1_?NumericQ, y1_?NumericQ}, {x2_?NumericQ, y2_?NumericQ}, color_List] := Module[
  {na, res1d, dims, colorNA},
  na = NumericArray[ImageData[img, "Byte"], "UnsignedInteger8"];
  dims = Dimensions[na];
  colorNA = NumericArray[Round[color * 255], "UnsignedInteger8"];
  res1d = imageLinkDrawLineMemoryFunc[na, N[x1], N[y1], N[x2], N[y2], colorNA];
  
  Image[NumericArray[ArrayReshape[Normal[res1d], dims], "UnsignedInteger8"], "Byte", ColorSpace -> ImageColorSpace[img]]
]

ImageLinkDrawRectangleMemory[img_Image, {x_Integer, y_Integer, w_Integer, h_Integer}, color_List, OptionsPattern[]] := Module[
  {na, res1d, dims, colorNA, filled},
  na = NumericArray[ImageData[img, "Byte"], "UnsignedInteger8"];
  dims = Dimensions[na];
  colorNA = NumericArray[Round[color * 255], "UnsignedInteger8"];
  filled = TrueQ[OptionValue[Filled]];
  res1d = imageLinkDrawRectMemoryFunc[na, x, y, w, h, colorNA, filled];
  
  Image[NumericArray[ArrayReshape[Normal[res1d], dims], "UnsignedInteger8"], "Byte", ColorSpace -> ImageColorSpace[img]]
]

ImageLinkDrawCircleMemory[img_Image, {x_Integer, y_Integer}, radius_Integer, color_List, OptionsPattern[]] := Module[
  {na, res1d, dims, colorNA, filled},
  na = NumericArray[ImageData[img, "Byte"], "UnsignedInteger8"];
  dims = Dimensions[na];
  colorNA = NumericArray[Round[color * 255], "UnsignedInteger8"];
  filled = TrueQ[OptionValue[Filled]];
  res1d = imageLinkDrawCircleMemoryFunc[na, x, y, radius, colorNA, filled];
  
  Image[NumericArray[ArrayReshape[Normal[res1d], dims], "UnsignedInteger8"], "Byte", ColorSpace -> ImageColorSpace[img]]
]

ImageLinkDrawEllipseMemory[img_Image, {x_Integer, y_Integer}, {rx_Integer, ry_Integer}, color_List, OptionsPattern[]] := Module[
  {na, res1d, dims, colorNA, filled},
  na = NumericArray[ImageData[img, "Byte"], "UnsignedInteger8"];
  dims = Dimensions[na];
  colorNA = NumericArray[Round[color * 255], "UnsignedInteger8"];
  filled = TrueQ[OptionValue[Filled]];
  res1d = imageLinkDrawEllipseMemoryFunc[na, x, y, rx, ry, colorNA, filled];
  
  Image[NumericArray[ArrayReshape[Normal[res1d], dims], "UnsignedInteger8"], "Byte", ColorSpace -> ImageColorSpace[img]]
]

ImageLinkDrawPolygonMemory[img_Image, points:{{_Integer, _Integer}..}, color_List, OptionsPattern[]] := Module[
  {na, res1d, dims, colorNA, filled, pxNA, pyNA},
  na = NumericArray[ImageData[img, "Byte"], "UnsignedInteger8"];
  dims = Dimensions[na];
  colorNA = NumericArray[Round[color * 255], "UnsignedInteger8"];
  filled = TrueQ[OptionValue[Filled]];
  pxNA = NumericArray[points[[All, 1]], "Integer64"];
  pyNA = NumericArray[points[[All, 2]], "Integer64"];
  res1d = imageLinkDrawPolygonMemoryFunc[na, pxNA, pyNA, colorNA, filled];
  
  Image[NumericArray[ArrayReshape[Normal[res1d], dims], "UnsignedInteger8"], "Byte", ColorSpace -> ImageColorSpace[img]]
]

ImageLinkShrinkWidthMemory[img_Image, targetWidth_Integer] := Module[
  {na, res1d, dims},
  na = NumericArray[ImageData[img, "Byte"], "UnsignedInteger8"];
  dims = Dimensions[na];
  
  If[targetWidth >= dims[[2]], Return[img]];

  res1d = imageLinkShrinkWidthMemoryFunc[na, targetWidth];
  
  Image[NumericArray[ArrayReshape[Normal[res1d], {dims[[1]], targetWidth, dims[[3]]}], "UnsignedInteger8"], "Byte", ColorSpace -> ImageColorSpace[img]]
]

ImageLinkDrawTextMemory[img_Image, text_String, {x_Integer, y_Integer}, scale_?NumericQ, fontPath_String, color_List] := Module[
  {na, res1d, dims, colorNA},
  na = NumericArray[ImageData[img, "Byte"], "UnsignedInteger8"];
  dims = Dimensions[na];
  colorNA = NumericArray[Round[color * 255], "UnsignedInteger8"];
  res1d = imageLinkDrawTextMemoryFunc[na, x, y, N[scale], ExpandFileName[fontPath], text, colorNA];
  Image[NumericArray[ArrayReshape[Normal[res1d], dims], "UnsignedInteger8"], "Byte", ColorSpace -> ImageColorSpace[img]]
]

ImageLinkFloodFillMemory[img_Image, {x_Integer, y_Integer}, color_List] := Module[
  {na, res1d, dims, colorNA},
  na = NumericArray[ImageData[img, "Byte"], "UnsignedInteger8"];
  dims = Dimensions[na];
  colorNA = NumericArray[Round[color * 255], "UnsignedInteger8"];
  res1d = imageLinkFloodFillMemoryFunc[na, x, y, colorNA];
  Image[NumericArray[ArrayReshape[Normal[res1d], dims], "UnsignedInteger8"], "Byte", ColorSpace -> ImageColorSpace[img]]
]

ImageLinkDrawAntialiasedLineMemory[img_Image, {x1_Integer, y1_Integer}, {x2_Integer, y2_Integer}, color_List] := Module[
  {na, res1d, dims, colorNA},
  na = NumericArray[ImageData[img, "Byte"], "UnsignedInteger8"];
  dims = Dimensions[na];
  colorNA = NumericArray[Round[color * 255], "UnsignedInteger8"];
  res1d = imageLinkDrawAALineMemoryFunc[na, x1, y1, x2, y2, colorNA];
  Image[NumericArray[ArrayReshape[Normal[res1d], dims], "UnsignedInteger8"], "Byte", ColorSpace -> ImageColorSpace[img]]
]

ImageLinkDrawBezierMemory[img_Image, {{x1_, y1_}, {x2_, y2_}, {x3_, y3_}, {x4_, y4_}}, color_List] := Module[
  {na, res1d, dims, colorNA},
  na = NumericArray[ImageData[img, "Byte"], "UnsignedInteger8"];
  dims = Dimensions[na];
  colorNA = NumericArray[Round[color * 255], "UnsignedInteger8"];
  res1d = imageLinkDrawBezierMemoryFunc[na, Round[x1], Round[y1], Round[x2], Round[y2], Round[x3], Round[y3], Round[x4], Round[y4], colorNA];
  Image[NumericArray[ArrayReshape[Normal[res1d], dims], "UnsignedInteger8"], "Byte", ColorSpace -> ImageColorSpace[img]]
]

End[]
EndPackage[]
