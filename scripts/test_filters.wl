PacletDirectoryLoad[FileNameJoin[{Directory[], "ImageLink"}]];
Needs["ImageLink`"]

Export["input.png", RandomImage[1, {100, 100}]];

Print["Testing Blur..."];
Print[ImageLinkBlur["input.png", "blur.png", 2.0]];

Print["Testing Unsharpen..."];
Print[ImageLinkUnsharpen["input.png", "unsharpen.png", 1.5, 10]];

If[FileExistsQ["blur.png"], Print["Blur OK"]];
If[FileExistsQ["unsharpen.png"], Print["Unsharpen OK"]];
