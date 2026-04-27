lib = FileNameJoin[{Directory[], "ImageLink", "LibraryResources", "MacOSX-ARM64", "librust.dylib"}];
func = LibraryFunctionLoad[lib, "get_version", {}, "UTF8String"];
Print[func[]];
