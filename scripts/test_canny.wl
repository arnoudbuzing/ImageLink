PacletDirectoryLoad[FileNameJoin[{Directory[], "ImageLink"}]];
Needs["ImageLink`"]

img = RandomImage[1, {100, 100}, ColorSpace -> "RGB"];
Print["Original Dimensions: ", ImageDimensions[img]];

Print["Testing Canny Edge Detection..."];
cannyImg = ImageLinkCannyMemory[img, 10.0, 50.0];
Print["Canny Image Dimensions: ", ImageDimensions[cannyImg]];
Print["Canny Image ColorSpace: ", ImageColorSpace[cannyImg]];
