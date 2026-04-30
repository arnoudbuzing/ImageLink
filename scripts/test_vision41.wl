PacletDirectoryLoad["/Users/arnoudb/github/ImageLink"];
Needs["ArnoudBuzing`ImageLink`"];

img = ExampleData[{"TestImage", "Lena"}];

(* 1. Distance Transform *)
dt = ImageLinkDistanceTransformMemory[img, 1];
Print["Distance Transform dimensions: ", ImageDimensions[dt]];

(* 2. FAST9 Corners *)
corners = ImageLinkCornersFast9Memory[img, 50];
Print["Number of FAST9 corners: ", Length[corners]];

(* 3. Template Matching *)
template = ImageCrop[img, {50, 50}];
match = ImageLinkMatchTemplateMemory[img, template, 4];
Print["Match Template dimensions: ", ImageDimensions[match]];
