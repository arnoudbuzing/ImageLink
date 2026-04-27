PacletDirectoryLoad[FileNameJoin[{Directory[], "ImageLink"}]];
Needs["ImageLink`"]

Export["input.png", RandomImage[1, {120, 80}]];

Print["Testing Dimensions..."];
Print[ImageLinkDimensions["input.png"]];

Print["Testing ColorType..."];
Print[ImageLinkColorType["input.png"]];
