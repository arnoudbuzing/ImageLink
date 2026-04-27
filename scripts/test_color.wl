PacletDirectoryLoad[FileNameJoin[{Directory[], "ImageLink"}]];
Needs["ArnoudBuzing`ImageLink`"]

Export["input.png", RandomImage[1, {100, 100}]];

Print["Testing Grayscale..."];
Print[ImageLinkGrayscale["input.png", "grayscale.png"]];

Print["Testing Invert..."];
Print[ImageLinkInvert["input.png", "invert.png"]];

If[FileExistsQ["grayscale.png"], Print["Grayscale OK"]];
If[FileExistsQ["invert.png"], Print["Invert OK"]];
