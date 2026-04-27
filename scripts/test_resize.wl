$ScriptDir = DirectoryName[$InputFileName];
PacletDirectoryLoad[ParentDirectory[$ScriptDir]];
Needs["ArnoudBuzing`ImageLink`"]

inputPath = FileNameJoin[{$ScriptDir, "input.png"}];
outputPath = FileNameJoin[{$ScriptDir, "output.png"}];

Export[inputPath, RandomImage[1, {100, 100}]];
result = ImageLinkResize[inputPath, outputPath, {50, 50}, Method -> "Lanczos3"];

Print["Result: ", result];
If[FileExistsQ[outputPath],
    img = Import[outputPath];
    Print["New Dimensions: ", ImageDimensions[img]];
]
