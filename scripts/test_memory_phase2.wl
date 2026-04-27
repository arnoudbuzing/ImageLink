PacletDirectoryLoad[FileNameJoin[{Directory[], "ImageLink"}]];
Needs["ImageLink`"]

img = RandomImage[1, {60, 40}, ColorSpace -> "RGB"];
Print["Original Dimensions: ", ImageDimensions[img]];

Print["Testing RotateMemory (90 degrees)..."];
rotatedImg = ImageLinkRotateMemory[img, 90];
Print["Rotated Image Dimensions: ", ImageDimensions[rotatedImg]];

Print["Testing GrayscaleMemory..."];
grayImg = ImageLinkGrayscaleMemory[img];
Print["Grayscale Image Dimensions: ", ImageDimensions[grayImg]];
Print["Grayscale Image ColorSpace: ", ImageColorSpace[grayImg]];
