PacletDirectoryLoad[FileNameJoin[{Directory[], "ImageLink"}]];
Needs["ImageLink`"]

img = RandomImage[1, {100, 100}, ColorSpace -> "RGB"];
Print["Original Dimensions: ", ImageDimensions[img]];

Print["Testing CropMemory (x=10, y=10, w=30, h=40)..."];
croppedImg = ImageLinkCropMemory[img, {10, 10, 30, 40}];
Print["Cropped Image Dimensions: ", ImageDimensions[croppedImg]];

Print["Testing ResizeMemory (w=200, h=150)..."];
resizedImg = ImageLinkResizeMemory[img, {200, 150}];
Print["Resized Image Dimensions: ", ImageDimensions[resizedImg]];
