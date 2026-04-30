PacletDirectoryLoad["/Users/arnoudb/github/ImageLink"];
Needs["ArnoudBuzing`ImageLink`"];

img = ExampleData[{"TestImage", "Lena"}];

rotated = ImageLinkRotateAboutCenterMemory[img, Pi/4.0];
Print["Rotated image dimensions: ", ImageDimensions[rotated]];

(* Identity matrix *)
mat = {{1.0, 0.0, 0.0}, {0.0, 1.0, 0.0}, {0.0, 0.0, 1.0}};
affine = ImageLinkAffineMemory[img, mat];
Print["Affine image dimensions: ", ImageDimensions[affine]];
