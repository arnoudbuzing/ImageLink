BeginPackage["ImageLink`"]

ImageLinkVersion::usage = "ImageLinkVersion[] returns the version string of the Rust library."

Begin["`Private`"]

$LibraryFile = FindLibrary["librust"];

(* wolfram_library_link #[export] wraps the function with its exact name or something else?
   Usually, just the function name works. *)
imageLinkVersionFunc = LibraryFunctionLoad[$LibraryFile, "get_version", {}, "UTF8String"];

ImageLinkVersion[] := imageLinkVersionFunc[]

End[]
EndPackage[]
