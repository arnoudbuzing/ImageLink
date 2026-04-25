PacletDirectoryLoad[FileNameJoin[{Directory[], "ImageLink"}]];
Needs["ImageLink`"]

(* Create a 10x10 completely black image *)
data = ConstantArray[{0., 0., 0.}, {10, 10}];

(* Put a single red pixel in the middle *)
data[[5, 5]] = {1.0, 0.0, 0.0};
img = Image[data, "Real"];

Print["Original Red Channel Center:"];
Print[ImageData[img][[3;;7, 3;;7, 1]]];

Print["Testing Dilate with radius 2 (5x5 neighborhood)..."];
dilatedImg = ImageLinkDilateMemory[img, 2];

Print["Dilated Red Channel Center:"];
Print[ImageData[dilatedImg][[3;;7, 3;;7, 1]]];
