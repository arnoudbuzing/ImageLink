PacletDirectoryLoad["/Users/arnoudb/github/ImageLink"];
Needs["ArnoudBuzing`ImageLink`"];

img = ExampleData[{"TestImage", "Lena"}];
gray1 = ColorConvert[img, "Grayscale"];
gray2 = ColorConvert[ExampleData[{"TestImage", "Mandrill"}], "Grayscale"];

kLevel = ImageLinkKapurLevelMemory[gray1];
Print["Kapur Level: ", kLevel];

matched = ImageLinkMatchHistogramMemory[gray1, gray2];
Print["Matched Image Dimensions: ", ImageDimensions[matched]];
