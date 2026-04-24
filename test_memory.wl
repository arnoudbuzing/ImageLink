PacletDirectoryLoad[FileNameJoin[{Directory[], "ImageLink"}]];
Needs["ImageLink`"]

img = RandomImage[1, {100, 100}, ColorSpace -> "RGB"];
Print["Original Dimensions: ", ImageDimensions[img]];

Print["Testing BlurMemory..."];
blurredImg = ImageLinkBlurMemory[img, 5.0];

Print["Blurred Image Dimensions: ", ImageDimensions[blurredImg]];
Print["Is blurred image an Image object? ", Head[blurredImg] === Image];
