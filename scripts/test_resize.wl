PacletDirectoryLoad[FileNameJoin[{Directory[], "ImageLink"}]];
Needs["ImageLink`"]

Export["input.png", RandomImage[1, {100, 100}]];
result = ImageLinkResize["input.png", "output.png", {50, 50}, Method -> "Lanczos3"];

Print["Result: ", result];
If[FileExistsQ["output.png"],
    img = Import["output.png"];
    Print["New Dimensions: ", ImageDimensions[img]];
]
