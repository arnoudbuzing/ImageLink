PacletDirectoryLoad[FileNameJoin[{Directory[], "ImageLink"}]];
Needs["ImageLink`"]

img = Import["/Users/arnoudb/stash/image/scripts/dog.jpg"];
Print["Testing Median Filter..."];
medianImg = ImageLinkMedianFilterMemory[img, 3, 3];
Export["/Users/arnoudb/stash/image/scripts/dog_median.png", medianImg];
Print["Saved to dog_median.png"];

Print["Testing Filter 3x3 (Edge Detection Kernel)..."];
kernel = {{-1, -1, -1}, {-1, 8, -1}, {-1, -1, -1}};
filterImg = ImageLinkFilter3x3Memory[img, kernel];
Export["/Users/arnoudb/stash/image/scripts/dog_filter3x3.png", filterImg];
Print["Saved to dog_filter3x3.png"];
