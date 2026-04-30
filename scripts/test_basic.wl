$LibraryFile = FileNameJoin[{DirectoryName[$InputFileName], "..", "ImageLink", "LibraryResources", $SystemID, "librust.dylib"}];
versionFunc = LibraryFunctionLoad[$LibraryFile, "get_version", {}, "UTF8String"];
Print["Version: ", versionFunc[]];
