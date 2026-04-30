AppendTo[$Path, ExpandFileName[Directory[] <> "/../"]];
<<ImageLink`
Print["Starting test_gradients.wl"];

img = Image[Table[If[(i-50)^2 + (j-50)^2 < 400, 255, 0], {i, 100}, {j, 100}], "Byte"]

sobel = ImageLinkSobelGradientsMemory[img];
Print["Sobel gradients max: ", Max[ImageData[sobel]]];

hSobel = ImageLinkHorizontalSobelMemory[img];
Print["Horizontal sobel length: ", Length[Flatten[hSobel]]];

hScharr = ImageLinkHorizontalScharrMemory[img];
Print["Horizontal scharr length: ", Length[Flatten[hScharr]]];

Print["Done!"];
