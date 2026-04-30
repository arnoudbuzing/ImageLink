PacletDirectoryLoad["/Users/arnoudb/github/ImageLink"];
Needs["ArnoudBuzing`ImageLink`"];

Print["Kernel Loaded successfully!"];
Print["Version: ", ImageLinkVersion[]];

img = ExampleData[{"TestImage", "Lena"}];
gray = ColorConvert[img, "Grayscale"];
binary = Binarize[gray];

lines = ImageLinkHoughLinesMemory[binary, 50, 2];
Print["Detected lines: ", Length[lines]];

openImg = ImageLinkMorphologyOpenMemory[gray, 1, 2];
Print["Open image dimensions: ", ImageDimensions[openImg]];

closeImg = ImageLinkMorphologyCloseMemory[gray, 1, 2];
Print["Close image dimensions: ", ImageDimensions[closeImg]];
