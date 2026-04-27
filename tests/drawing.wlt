PacletDirectoryAdd[Directory[]]
Needs["ImageLink`"]

$Blank = Image[ConstantArray[0, {100, 100, 3}], "Byte"];

VerificationTest[
    Head[ImageLinkDrawLineMemory[$Blank, {10, 10}, {90, 90}, {1, 0, 0}]],
    Image,
    TestID -> "DrawLine-Head"
]

VerificationTest[
    Head[ImageLinkDrawRectangleMemory[$Blank, {20, 20, 30, 30}, {0, 1, 0}, Filled -> True]],
    Image,
    TestID -> "DrawRect-Head"
]

VerificationTest[
    Head[ImageLinkDrawCircleMemory[$Blank, {50, 50}, 20, {0, 0, 1}]],
    Image,
    TestID -> "DrawCircle-Head"
]
