PacletDirectoryLoad[FileNameJoin[{Directory[], "ImageLink"}]];
Needs["ImageLink`"]

img = RandomImage[1, {50, 50}, ColorSpace -> "RGB"];
Print["Original Dimensions: ", ImageDimensions[img]];

Print["Testing InvertMemory..."];
invertedImg = ImageLinkInvertMemory[img];
Print["Inverted Image Dimensions: ", ImageDimensions[invertedImg]];

Print["Testing UnsharpenMemory..."];
unsharpenedImg = ImageLinkUnsharpenMemory[img, 1.5, 10];
Print["Unsharpened Image Dimensions: ", ImageDimensions[unsharpenedImg]];

Print["Testing FlipMemory..."];
flippedImg = ImageLinkFlipMemory[img, "Vertical"];
Print["Flipped Image Dimensions: ", ImageDimensions[flippedImg]];
