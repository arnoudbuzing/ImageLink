PacletDirectoryLoad[FileNameJoin[{Directory[], "ImageLink"}]];
Needs["ImageLink`"]

Export["input.png", RandomImage[1, {100, 100}]];

Print["Testing Flip..."];
Print[ImageLinkFlip["input.png", "flip.png", "Vertical"]];

Print["Testing Rotate..."];
Print[ImageLinkRotate["input.png", "rotate.png", 90]];

Print["Testing Crop..."];
Print[ImageLinkCrop["input.png", "crop.png", {10, 10, 50, 50}]];

If[FileExistsQ["flip.png"], Print["Flip OK"]];
If[FileExistsQ["rotate.png"], Print["Rotate OK"]];
If[FileExistsQ["crop.png"], 
  img = Import["crop.png"];
  Print["Crop Dimensions: ", ImageDimensions[img]];
];
