BeginPackage["ImageLink`"]

ImageLinkVersion::usage = "ImageLinkVersion[] returns the version string of the Rust library."
ImageLinkResize::usage = "ImageLinkResize[input, output, {width, height}, Method -> \"Triangle\"] resizes an image and saves it."

Begin["`Private`"]

$LibraryFile = FindLibrary["librust"];

imageLinkVersionFunc = LibraryFunctionLoad[$LibraryFile, "get_version", {}, "UTF8String"];
imageLinkResizeFunc = LibraryFunctionLoad[$LibraryFile, "resize_image", {"UTF8String", "UTF8String", Integer, Integer, "UTF8String"}, "UTF8String"];

ImageLinkVersion[] := imageLinkVersionFunc[]

Options[ImageLinkResize] = {Method -> "Triangle"}

ImageLinkResize[input_String, output_String, {width_Integer, height_Integer}, OptionsPattern[]] := Module[{method},
  method = OptionValue[Method];
  imageLinkResizeFunc[ExpandFileName[input], ExpandFileName[output], width, height, method]
]

End[]
EndPackage[]
