PacletDirectoryLoad[FileNameJoin[{Directory[], "ImageLink"}]];
Needs["ImageLink`"]

img = Import["/Users/arnoudb/stash/image/scripts/dog.jpg"];
Print["Testing Draw Line..."];
lineImg = ImageLinkDrawLineMemory[img, {10, 10}, {200, 200}, {1, 0, 0}];
Export["/Users/arnoudb/stash/image/scripts/dog_line.png", lineImg];
Print["Saved to dog_line.png"];

Print["Testing Draw Rectangle (Hollow)..."];
rectImg = ImageLinkDrawRectangleMemory[img, {50, 50, 100, 150}, {0, 1, 0}];
Export["/Users/arnoudb/stash/image/scripts/dog_rect_hollow.png", rectImg];
Print["Saved to dog_rect_hollow.png"];

Print["Testing Draw Rectangle (Filled)..."];
rectImg2 = ImageLinkDrawRectangleMemory[img, {100, 100, 50, 50}, {0, 0, 1}, Filled -> True];
Export["/Users/arnoudb/stash/image/scripts/dog_rect_filled.png", rectImg2];
Print["Saved to dog_rect_filled.png"];
