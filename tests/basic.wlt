PacletDirectoryAdd[Directory[]]
Needs["ArnoudBuzing`ImageLink`"]

VerificationTest[
    StringQ[ImageLinkVersion[]],
    True,
    TestID -> "Version-String"
]

VerificationTest[
    ImageLinkDimensions[FileNameJoin[{"scripts", "input.png"}]],
    {120, 80},
    TestID -> "Dimensions-Input"
]

VerificationTest[
    ImageLinkColorType[FileNameJoin[{"scripts", "input.png"}]],
    "L16",
    TestID -> "ColorType-Input"
]
