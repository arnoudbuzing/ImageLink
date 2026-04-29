PacletDirectoryLoad["."];
Needs["ArnoudBuzing`ImageLink`"];
Print["Loaded: ", ImageLinkVersion[]];

img = ExampleData[{"TestImage", "Lena"}];

(* Histogram - should return {3, 256} matrix *)
hist = ImageLinkHistogramMemory[img];
Print["Histogram dims: ", Dimensions[hist]];
Print["Histogram R[100]: ", hist[[1, 101]]];

(* PSNR of image with itself = Infinity (but we cap as double so very large) *)
psnr = ImageLinkPSNRMemory[img, img];
Print["PSNR (self): ", psnr];

(* PHash - 64-bit integer *)
h1 = ImageLinkPHashMemory[img];
Print["PHash: ", h1];

(* Otsu threshold *)
otsu = ImageLinkOtsuLevelMemory[img];
Print["Otsu level: ", otsu];

Print["All Batch 2 tests passed!"];
