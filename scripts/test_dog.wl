PacletDirectoryLoad[FileNameJoin[{Directory[], "ImageLink"}]];
Needs["ArnoudBuzing`ImageLink`"]

img = Import["/Users/arnoudb/stash/image/scripts/dog.jpg"];
Print["Original dims: ", ImageDimensions[img]];
Print["Original ColorSpace: ", ImageColorSpace[img]];

out = ImageLinkDilateMemory[img, 1];
Print["Dilated dims: ", ImageDimensions[out]];
Export["/Users/arnoudb/stash/image/scripts/dog_dilated.png", out];
Print["Saved to dog_dilated.png"];

outErode = ImageLinkErodeMemory[img, 1];
Export["/Users/arnoudb/stash/image/scripts/dog_eroded.png", outErode];
Print["Saved to dog_eroded.png"];
