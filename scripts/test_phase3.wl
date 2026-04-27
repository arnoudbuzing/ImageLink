PacletDirectoryLoad[FileNameJoin[{Directory[], "ImageLink"}]];
Needs["ImageLink`"]

img = Import["/Users/arnoudb/stash/image/scripts/dog.jpg"];
Print["Testing Equalize Histogram..."];
eqImg = ImageLinkEqualizeHistogramMemory[img];
Export["/Users/arnoudb/stash/image/scripts/dog_eq.png", eqImg];
Print["Saved to dog_eq.png"];

Print["Testing Adaptive Threshold..."];
threshImg = ImageLinkAdaptiveThresholdMemory[img, 5, 2];
Export["/Users/arnoudb/stash/image/scripts/dog_thresh.png", threshImg];
Print["Saved to dog_thresh.png"];
