PacletDirectoryLoad[FileNameJoin[{Directory[], "ImageLink"}]];
Needs["ImageLink`"]

img = Import["/Users/arnoudb/stash/image/scripts/dog.jpg"];

Print["Testing Draw Circle (Hollow)..."];
circleImg = ImageLinkDrawCircleMemory[img, {150, 150}, 50, {1, 0, 0}];
Export["/Users/arnoudb/stash/image/scripts/dog_circle_hollow.png", circleImg];

Print["Testing Draw Circle (Filled)..."];
circleImg2 = ImageLinkDrawCircleMemory[img, {250, 150}, 50, {0, 1, 0}, Filled -> True];
Export["/Users/arnoudb/stash/image/scripts/dog_circle_filled.png", circleImg2];

Print["Testing Draw Ellipse (Hollow)..."];
ellipseImg = ImageLinkDrawEllipseMemory[img, {150, 300}, {80, 40}, {0, 0, 1}];
Export["/Users/arnoudb/stash/image/scripts/dog_ellipse_hollow.png", ellipseImg];

Print["Testing Draw Polygon (Filled)..."];
polyImg = ImageLinkDrawPolygonMemory[img, {{50, 50}, {150, 100}, {100, 200}, {20, 150}}, {1, 1, 0}, Filled -> True];
Export["/Users/arnoudb/stash/image/scripts/dog_poly_filled.png", polyImg];

Print["Testing Draw Polygon (Hollow)..."];
polyImg2 = ImageLinkDrawPolygonMemory[img, {{200, 50}, {300, 100}, {250, 200}, {170, 150}}, {0, 1, 1}];
Export["/Users/arnoudb/stash/image/scripts/dog_poly_hollow.png", polyImg2];

Print["Tests completed successfully!"];
