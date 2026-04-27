PacletDirectoryLoad[FileNameJoin[{Directory[], "ImageLink"}]];
Needs["ArnoudBuzing`ImageLink`"]

img = RandomImage[1, {10, 10}, ColorSpace -> "RGB"];
Print["Original Dimensions: ", ImageDimensions[img]];

Print["Testing Dilate..."];
dilatedImg = ImageLinkDilateMemory[img, 2];
Print["Dilated Image Dimensions: ", ImageDimensions[dilatedImg]];
Print["Dilated Image ColorSpace: ", ImageColorSpace[dilatedImg]];

Print["Testing Erode..."];
erodedImg = ImageLinkErodeMemory[img, 2];
Print["Eroded Image Dimensions: ", ImageDimensions[erodedImg]];
Print["Eroded Image ColorSpace: ", ImageColorSpace[erodedImg]];
