BeginPackage["ImageLink`"]

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

Begin["`Private`"]

$LibraryFile = FindLibrary["librust"];

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

ImageLinkVersion[] := imageLinkVersionFunc[]

Options[ImageLinkResize] = {Method -> "Triangle"}
Options[ImageLinkResizeMemory] = {Method -> "Triangle"}

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

End[]
EndPackage[]
