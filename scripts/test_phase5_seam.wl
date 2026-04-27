PacletDirectoryLoad[FileNameJoin[{Directory[], "ImageLink"}]];
Needs["ImageLink`"]

img = Import["/Users/arnoudb/stash/image/scripts/dog.jpg"];
Print["Original dimensions: ", ImageDimensions[img]];

Print["Testing Seam Carving (Shrink Width to 300)..."];
shrunkImg = ImageLinkShrinkWidthMemory[img, 300];
Print["Shrunk dimensions: ", ImageDimensions[shrunkImg]];
Export["/Users/arnoudb/stash/image/scripts/dog_shrunk.png", shrunkImg];

Print["Tests completed successfully!"];
