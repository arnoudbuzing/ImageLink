PacletDirectoryLoad[FileNameJoin[{Directory[], "ImageLink"}]];
Needs["ArnoudBuzing`ImageLink`"]

img = Import["/Users/arnoudb/stash/image/scripts/dog.jpg"];

(* Extract Red Channel *)
redChannel = ColorSeparate[img][[1]];

(* WL Dilation of Red Channel *)
wlRedDilated = Dilation[redChannel, BoxMatrix[1]];

(* My Dilation of Red Channel *)
rustRedDilated = ImageLinkDilateMemory[redChannel, 1];

diff = ImageDifference[wlRedDilated, rustRedDilated];
Print["Max difference between WL Red Dilation and Rust Red Dilation: ", Max[ImageData[diff]]];

Print["WL red max: ", Max[ImageData[wlRedDilated]]];
Print["Rust red max: ", Max[ImageData[rustRedDilated]]];
