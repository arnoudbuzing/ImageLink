PacletDirectoryAdd[Directory[]]
Needs["ArnoudBuzing`ImageLink`"]

$TestImage = Image[RandomReal[1, {100, 100, 3}], "Byte"];

VerificationTest[
    ImageDimensions[ImageLinkShrinkWidthMemory[$TestImage, 80]],
    {80, 100},
    TestID -> "ShrinkWidth-Dimensions"
]

VerificationTest[
    ImageColorSpace[ImageLinkCannyMemory[$TestImage, 10, 50]],
    "Grayscale",
    TestID -> "Canny-ColorSpace"
]

VerificationTest[
    Head[ImageLinkEqualizeHistogramMemory[$TestImage]],
    Image,
    TestID -> "Equalize-Head"
]
