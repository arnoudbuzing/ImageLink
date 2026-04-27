PacletDirectoryLoad[FileNameJoin[{Directory[], "ImageLink"}]];
Needs["ArnoudBuzing`ImageLink`"]

img = Import["/Users/arnoudb/stash/image/scripts/dog.jpg"];

(* WL's built-in Dilation with a 3x3 square structuring element *)
wlDilated = Dilation[img, BoxMatrix[1]];

(* Our custom Dilation *)
rustDilated = ImageLinkDilateMemory[img, 1];

diff = ImageDifference[wlDilated, rustDilated];
Print["Max difference between WL Dilation and Rust Dilation: ", Max[ImageData[diff]]];

Export["/Users/arnoudb/stash/image/scripts/dog_wl_dilated.png", wlDilated];
