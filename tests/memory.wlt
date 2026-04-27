PacletDirectoryAdd[Directory[]]
Needs["ArnoudBuzing`ImageLink`"]

$TestImage = Image[RandomReal[1, {100, 100, 3}], "Real"];
$TestImageByte = Image[$TestImage, "Byte"];

VerificationTest[
    Head[ImageLinkInvertMemory[$TestImageByte]],
    Image,
    TestID -> "InvertMemory-Head"
]

VerificationTest[
    ImageDimensions[ImageLinkResizeMemory[$TestImageByte, {50, 50}]],
    {50, 50},
    TestID -> "ResizeMemory-Dimensions"
]

VerificationTest[
    ImageColorSpace[ImageLinkGrayscaleMemory[$TestImageByte]],
    "Grayscale",
    TestID -> "GrayscaleMemory-ColorSpace"
]

VerificationTest[
    ImageDimensions[ImageLinkFlipMemory[$TestImageByte, "Horizontal"]],
    {100, 100},
    TestID -> "FlipMemory-Dimensions"
]
