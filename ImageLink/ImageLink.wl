BeginPackage["ArnoudBuzing`ImageLink`"]

ImageLinkVersion::usage = "ImageLinkVersion[] returns the version string of the Rust library."
ImageLinkResize::usage = "ImageLinkResize[input, output, {width, height}, Method -> \"Triangle\"] resizes an image and saves it."
ImageLinkFlip::usage = "ImageLinkFlip[input, output, direction] flips an image. direction can be \"Horizontal\" or \"Vertical\"."
ImageLinkRotate::usage = "ImageLinkRotate[input, output, angle] rotates an image. angle can be 90, 180, or 270."
ImageLinkCrop::usage = "ImageLinkCrop[input, output, {x, y, w, h}] crops an image."
ImageLinkGrayscale::usage = "ImageLinkGrayscale[input, output] converts an image to grayscale."
ImageLinkInvert::usage = "ImageLinkInvert[input, output] inverts the colors of an image."
ImageLinkBlur::usage = "ImageLinkBlur[input, output, sigma] applies a Gaussian blur with the specified sigma."
ImageLinkUnsharpen::usage = "ImageLinkUnsharpen[input, output, sigma, threshold] applies an unsharp mask."
ImageLinkDimensions::usage = "ImageLinkDimensions[input] returns the dimensions {width, height} of an image."
ImageLinkColorType::usage = "ImageLinkColorType[input] returns the color type of an image."
ImageLinkBlurMemory::usage = "ImageLinkBlurMemory[image, sigma] applies a Gaussian blur to an Image object directly in memory."
ImageLinkInvertMemory::usage = "ImageLinkInvertMemory[image] inverts colors of an Image object directly in memory."
ImageLinkUnsharpenMemory::usage = "ImageLinkUnsharpenMemory[image, sigma, threshold] applies an unsharp mask to an Image object directly in memory."
ImageLinkFlipMemory::usage = "ImageLinkFlipMemory[image, direction] flips an Image object directly in memory. direction can be \"Horizontal\" or \"Vertical\"."
ImageLinkRotateMemory::usage = "ImageLinkRotateMemory[image, angle] rotates an Image object directly in memory. angle can be 90, 180, or 270."
ImageLinkGrayscaleMemory::usage = "ImageLinkGrayscaleMemory[image] converts an Image object to grayscale directly in memory."
ImageLinkCropMemory::usage = "ImageLinkCropMemory[image, {x, y, w, h}] crops an Image object directly in memory."
ImageLinkResizeMemory::usage = "ImageLinkResizeMemory[image, {width, height}, Method -> \"Triangle\"] resizes an Image object directly in memory."
ImageLinkCannyMemory::usage = "ImageLinkCannyMemory[image, low, high] applies Canny edge detection directly in memory."
ImageLinkDilateMemory::usage = "ImageLinkDilateMemory[image, radius] dilates an Image object directly in memory."
ImageLinkErodeMemory::usage = "ImageLinkErodeMemory[image, radius] erodes an Image object directly in memory."
ImageLinkMedianFilterMemory::usage = "ImageLinkMedianFilterMemory[image, xRadius, yRadius] applies a median filter to an Image object directly in memory."
ImageLinkFilter3x3Memory::usage = "ImageLinkFilter3x3Memory[image, kernel] applies a 3x3 custom convolution kernel to an Image object directly in memory."
ImageLinkEqualizeHistogramMemory::usage = "ImageLinkEqualizeHistogramMemory[image] equalizes the histogram of an Image object directly in memory."
ImageLinkAdaptiveThresholdMemory::usage = "ImageLinkAdaptiveThresholdMemory[image, blockRadius, delta] applies an adaptive threshold directly in memory."
ImageLinkDrawLineMemory::usage = "ImageLinkDrawLineMemory[image, {x1, y1}, {x2, y2}, color] draws a line segment directly in memory."
ImageLinkDrawRectangleMemory::usage = "ImageLinkDrawRectangleMemory[image, {x, y, w, h}, color, Filled -> False] draws a rectangle directly in memory."
ImageLinkDrawCircleMemory::usage = "ImageLinkDrawCircleMemory[image, {x, y}, radius, color, Filled -> False] draws a circle directly in memory."
ImageLinkDrawEllipseMemory::usage = "ImageLinkDrawEllipseMemory[image, {x, y}, {rx, ry}, color, Filled -> False] draws an ellipse directly in memory."
ImageLinkDrawPolygonMemory::usage = "ImageLinkDrawPolygonMemory[image, {{x1,y1}, {x2,y2}, ...}, color, Filled -> False] draws a polygon directly in memory."
ImageLinkShrinkWidthMemory::usage = "ImageLinkShrinkWidthMemory[img, targetWidth] shrinks the width of an image using seam carving.";
ImageLinkHoughLinesMemory::usage = "ImageLinkHoughLinesMemory[img, voteThreshold, suppressionRadius] detects lines using the Hough transform.";
ImageLinkMorphologyOpenMemory::usage = "ImageLinkMorphologyOpenMemory[img, norm, k] performs a morphological open operation.";
ImageLinkMorphologyCloseMemory::usage = "ImageLinkMorphologyCloseMemory[img, norm, k] performs a morphological close operation.";
ImageLinkRotateAboutCenterMemory::usage = "ImageLinkRotateAboutCenterMemory[img, theta, interpolation] rotates an image clockwise about its center by theta radians.";
ImageLinkAffineMemory::usage = "ImageLinkAffineMemory[img, matrix, interpolation] applies an affine projection matrix (3x3) to an image.";
ImageLinkKapurLevelMemory::usage = "ImageLinkKapurLevelMemory[img] computes Kapur's optimal threshold (0-255).";
ImageLinkMatchHistogramMemory::usage = "ImageLinkMatchHistogramMemory[img, target] matches the histogram of img to the target image.";
ImageLinkCornersFast9Memory::usage = "ImageLinkCornersFast9Memory[img, threshold] detects corners using the FAST-9 algorithm.";
ImageLinkMatchTemplateMemory::usage = "ImageLinkMatchTemplateMemory[img, template, method] performs template matching. Method: 1=SSE, 2=SSE Normalized, 3=CrossCorrelation, 4=CrossCorrelation Normalized.";
ImageLinkDistanceTransformMemory::usage = "ImageLinkDistanceTransformMemory[img, norm] computes the distance transform using L1 (1) or LInf (2) norm.";
ImageLinkCornersFast12Memory::usage = "ImageLinkCornersFast12Memory[img, threshold] detects corners using the FAST-12 algorithm.";
ImageLinkConnectedComponentsMemory::usage = "ImageLinkConnectedComponentsMemory[img, connectivity] returns an image with connected components labelled. Connectivity is 4 or 8.";
ImageLinkHogMemory::usage = "ImageLinkHogMemory[img, orientations, signed, cellSide, blockSide, blockStride] computes the Histogram of Oriented Gradients (HOG) descriptor for an image.";
ImageLinkFindContoursMemory::usage = "ImageLinkFindContoursMemory[img, threshold] returns a list of contours detected in the image.";
ImageLinkConvexHullMemory::usage = "ImageLinkConvexHullMemory[points] computes the convex hull of a set of 2D points.";
ImageLinkMinAreaRectMemory::usage = "ImageLinkMinAreaRectMemory[points] computes the minimum area bounding rectangle of a set of 2D points.";
ImageLinkApproximatePolygonMemory::usage = "ImageLinkApproximatePolygonMemory[points, epsilon, closed] approximates a polygon.";
ImageLinkArcLengthMemory::usage = "ImageLinkArcLengthMemory[points, closed] computes the arc length of a contour.";
ImageLinkContourAreaMemory::usage = "ImageLinkContourAreaMemory[points] computes the area of a contour.";
ImageLinkSobelGradientsMemory::usage = "ImageLinkSobelGradientsMemory[img] computes the 2D Sobel gradient magnitude of an image.";
ImageLinkPrewittGradientsMemory::usage = "ImageLinkPrewittGradientsMemory[img] computes the 2D Prewitt gradient magnitude of an image.";
ImageLinkHorizontalSobelMemory::usage = "ImageLinkHorizontalSobelMemory[img] computes the horizontal Sobel gradient of an image.";
ImageLinkVerticalSobelMemory::usage = "ImageLinkVerticalSobelMemory[img] computes the vertical Sobel gradient of an image.";
ImageLinkHorizontalPrewittMemory::usage = "ImageLinkHorizontalPrewittMemory[img] computes the horizontal Prewitt gradient of an image.";
ImageLinkVerticalPrewittMemory::usage = "ImageLinkVerticalPrewittMemory[img] computes the vertical Prewitt gradient of an image.";
ImageLinkHorizontalScharrMemory::usage = "ImageLinkHorizontalScharrMemory[img] computes the horizontal Scharr gradient of an image.";
ImageLinkVerticalScharrMemory::usage = "ImageLinkVerticalScharrMemory[img] computes the vertical Scharr gradient of an image.";
ImageLinkDrawTextMemory::usage = "ImageLinkDrawTextMemory[image, text, {x, y}, scale, fontPath, color] draws text directly in memory."
ImageLinkFloodFillMemory::usage = "ImageLinkFloodFillMemory[image, {x, y}, color] performs a flood fill directly in memory."
ImageLinkBilateralFilterMemory::usage = "ImageLinkBilateralFilterMemory[image, radius, sigmaSpatial, sigmaColor] applies a bilateral filter directly in memory."
ImageLinkLaplacianFilterMemory::usage = "ImageLinkLaplacianFilterMemory[image] applies a Laplacian filter directly in memory."
ImageLinkIntegralImageMemory::usage = "ImageLinkIntegralImageMemory[image] computes the integral image directly in memory."
ImageLinkIntegralSquaredImageMemory::usage = "ImageLinkIntegralSquaredImageMemory[image] computes the integral squared image directly in memory."
ImageLinkEvaluateHaarFeaturesMemory::usage = "ImageLinkEvaluateHaarFeaturesMemory[image, frameWidth, frameHeight] evaluates all Haar features for the given frame size on the image."
ImageLinkLocalBinaryPatternMemory::usage = "ImageLinkLocalBinaryPatternMemory[image] computes the Local Binary Pattern (LBP) image."
ImageLinkSuppressNonMaximumMemory::usage = "ImageLinkSuppressNonMaximumMemory[image, radius] suppresses non-maximum values in a local neighborhood."
ImageLinkDrawAntialiasedLineMemory::usage = "ImageLinkDrawAntialiasedLineMemory[image, {x1, y1}, {x2, y2}, color] draws an anti-aliased line segment directly in memory."
ImageLinkDrawBezierMemory::usage = "ImageLinkDrawBezierMemory[image, {p1, p2, p3, p4}, color] draws a cubic Bezier curve directly in memory."
ImageLinkHistogramMemory::usage = "ImageLinkHistogramMemory[image] returns a list of histograms (one per channel) for the image."
ImageLinkPSNRMemory::usage = "ImageLinkPSNRMemory[image1, image2] returns the Peak Signal-to-Noise Ratio between two images."
ImageLinkPHashMemory::usage = "ImageLinkPHashMemory[image] returns a 64-bit perceptual hash of the image."
ImageLinkOtsuLevelMemory::usage = "ImageLinkOtsuLevelMemory[image] returns the optimal threshold level using Otsu's method."

Begin["`Private`"]

$LibraryFile = FindLibrary["librust"];
$LibraryFileDrawing = FindLibrary["librust_drawing"];
$LibraryFileStats = FindLibrary["librust_stats"];
$LibraryFileGeometry = FindLibrary["librust_geometry"];

If[$LibraryFile === $Failed,
$LibraryFile = FileNameJoin[{DirectoryName[$InputFileName], "LibraryResources", $SystemID, "librust.dylib"}];
$LibraryFileStats = FileNameJoin[{DirectoryName[$InputFileName], "LibraryResources", $SystemID, "librust_stats.dylib"}];
$LibraryFileDrawing = FileNameJoin[{DirectoryName[$InputFileName], "LibraryResources", $SystemID, "librust_drawing.dylib"}];
$LibraryFileVision = FileNameJoin[{DirectoryName[$InputFileName], "LibraryResources", $SystemID, "librust_vision.dylib"}];
$LibraryFileGeometry = FileNameJoin[{DirectoryName[$InputFileName], "LibraryResources", $SystemID, "librust_geometry.dylib"}];
$LibraryFileFilter = FileNameJoin[{DirectoryName[$InputFileName], "LibraryResources", $SystemID, "librust_filter.dylib"}];
];

imageLinkVersionFunc = LibraryFunctionLoad[$LibraryFile, "get_version", {}, "UTF8String"];
imageLinkResizeFunc = LibraryFunctionLoad[$LibraryFile, "resize_image", {"UTF8String", "UTF8String", Integer, Integer, "UTF8String"}, "UTF8String"];
imageLinkFlipFunc = LibraryFunctionLoad[$LibraryFile, "flip_image", {"UTF8String", "UTF8String", "UTF8String"}, "UTF8String"];
imageLinkRotateFunc = LibraryFunctionLoad[$LibraryFile, "rotate_image", {"UTF8String", "UTF8String", Integer}, "UTF8String"];
imageLinkCropFunc = LibraryFunctionLoad[$LibraryFile, "crop_image", {"UTF8String", "UTF8String", Integer, Integer, Integer, Integer}, "UTF8String"];
imageLinkGrayscaleFunc = LibraryFunctionLoad[$LibraryFile, "grayscale_image", {"UTF8String", "UTF8String"}, "UTF8String"];
imageLinkInvertFunc = LibraryFunctionLoad[$LibraryFile, "invert_image", {"UTF8String", "UTF8String"}, "UTF8String"];
imageLinkBlurFunc = LibraryFunctionLoad[$LibraryFile, "blur_image", {"UTF8String", "UTF8String", Real}, "UTF8String"];
imageLinkUnsharpenFunc = LibraryFunctionLoad[$LibraryFile, "unsharpen_image", {"UTF8String", "UTF8String", Real, Integer}, "UTF8String"];
imageLinkDimensionsFunc = LibraryFunctionLoad[$LibraryFile, "image_dimensions", {"UTF8String"}, "UTF8String"];
imageLinkColorTypeFunc = LibraryFunctionLoad[$LibraryFile, "image_color_type", {"UTF8String"}, "UTF8String"];
imageLinkBlurMemoryFunc = LibraryFunctionLoad[$LibraryFile, "blur_memory", {{LibraryDataType[NumericArray, "UnsignedInteger8"]}, Real}, LibraryDataType[NumericArray, "UnsignedInteger8"]];
imageLinkInvertMemoryFunc = LibraryFunctionLoad[$LibraryFile, "invert_memory", {{LibraryDataType[NumericArray, "UnsignedInteger8"]}}, LibraryDataType[NumericArray, "UnsignedInteger8"]];
imageLinkUnsharpenMemoryFunc = LibraryFunctionLoad[$LibraryFile, "unsharpen_memory", {{LibraryDataType[NumericArray, "UnsignedInteger8"]}, Real, Integer}, LibraryDataType[NumericArray, "UnsignedInteger8"]];
imageLinkFlipMemoryFunc = LibraryFunctionLoad[$LibraryFile, "flip_memory", {{LibraryDataType[NumericArray, "UnsignedInteger8"]}, "UTF8String"}, LibraryDataType[NumericArray, "UnsignedInteger8"]];
imageLinkRotateMemoryFunc = LibraryFunctionLoad[$LibraryFile, "rotate_memory", {{LibraryDataType[NumericArray, "UnsignedInteger8"]}, Integer}, LibraryDataType[NumericArray, "UnsignedInteger8"]];
imageLinkGrayscaleMemoryFunc = LibraryFunctionLoad[$LibraryFile, "grayscale_memory", {{LibraryDataType[NumericArray, "UnsignedInteger8"]}}, LibraryDataType[NumericArray, "UnsignedInteger8"]];
imageLinkCropMemoryFunc = LibraryFunctionLoad[$LibraryFile, "crop_memory", {{LibraryDataType[NumericArray, "UnsignedInteger8"]}, Integer, Integer, Integer, Integer}, LibraryDataType[NumericArray, "UnsignedInteger8"]];
imageLinkResizeMemoryFunc = LibraryFunctionLoad[$LibraryFile, "resize_memory", {{LibraryDataType[NumericArray, "UnsignedInteger8"]}, Integer, Integer, "UTF8String"}, LibraryDataType[NumericArray, "UnsignedInteger8"]];
imageLinkCannyMemoryFunc = LibraryFunctionLoad[$LibraryFile, "canny_memory", {{LibraryDataType[NumericArray, "UnsignedInteger8"]}, Real, Real}, LibraryDataType[NumericArray, "UnsignedInteger8"]];
imageLinkDilateMemoryFunc = LibraryFunctionLoad[$LibraryFile, "dilate_memory", {{LibraryDataType[NumericArray, "UnsignedInteger8"]}, Integer}, LibraryDataType[NumericArray, "UnsignedInteger8"]];
imageLinkErodeMemoryFunc = LibraryFunctionLoad[$LibraryFile, "erode_memory", {{LibraryDataType[NumericArray, "UnsignedInteger8"]}, Integer}, LibraryDataType[NumericArray, "UnsignedInteger8"]];
imageLinkMedianFilterMemoryFunc = LibraryFunctionLoad[$LibraryFile, "median_memory", {{LibraryDataType[NumericArray, "UnsignedInteger8"]}, Integer, Integer}, LibraryDataType[NumericArray, "UnsignedInteger8"]];
imageLinkFilter3x3MemoryFunc = LibraryFunctionLoad[$LibraryFile, "filter3x3_memory", {{LibraryDataType[NumericArray, "UnsignedInteger8"]}, {LibraryDataType[NumericArray, "Real64"]}}, LibraryDataType[NumericArray, "UnsignedInteger8"]];
imageLinkEqualizeHistogramMemoryFunc = LibraryFunctionLoad[$LibraryFile, "equalize_memory", {{LibraryDataType[NumericArray, "UnsignedInteger8"]}}, LibraryDataType[NumericArray, "UnsignedInteger8"]];
imageLinkAdaptiveThresholdMemoryFunc = LibraryFunctionLoad[$LibraryFile, "adaptive_threshold_memory", {{LibraryDataType[NumericArray, "UnsignedInteger8"]}, Integer, Integer}, LibraryDataType[NumericArray, "UnsignedInteger8"]];
imageLinkDrawLineMemoryFunc = LibraryFunctionLoad[$LibraryFileDrawing, "draw_line_memory", {{LibraryDataType[NumericArray, "UnsignedInteger8"]}, Real, Real, Real, Real, {LibraryDataType[NumericArray, "UnsignedInteger8"]}}, LibraryDataType[NumericArray, "UnsignedInteger8"]];
imageLinkDrawRectMemoryFunc = LibraryFunctionLoad[$LibraryFileDrawing, "draw_rect_memory", {{LibraryDataType[NumericArray, "UnsignedInteger8"]}, Integer, Integer, Integer, Integer, {LibraryDataType[NumericArray, "UnsignedInteger8"]}, True|False}, LibraryDataType[NumericArray, "UnsignedInteger8"]];
imageLinkDrawCircleMemoryFunc = LibraryFunctionLoad[$LibraryFileDrawing, "draw_circle_memory", {{LibraryDataType[NumericArray, "UnsignedInteger8"]}, Integer, Integer, Integer, {LibraryDataType[NumericArray, "UnsignedInteger8"]}, True|False}, LibraryDataType[NumericArray, "UnsignedInteger8"]];
imageLinkDrawEllipseMemoryFunc = LibraryFunctionLoad[$LibraryFileDrawing, "draw_ellipse_memory", {{LibraryDataType[NumericArray, "UnsignedInteger8"]}, Integer, Integer, Integer, Integer, {LibraryDataType[NumericArray, "UnsignedInteger8"]}, True|False}, LibraryDataType[NumericArray, "UnsignedInteger8"]];
imageLinkDrawPolygonMemoryFunc = LibraryFunctionLoad[$LibraryFileDrawing, "draw_polygon_memory", {{LibraryDataType[NumericArray, "UnsignedInteger8"]}, {LibraryDataType[NumericArray, "Integer64"]}, {LibraryDataType[NumericArray, "Integer64"]}, {LibraryDataType[NumericArray, "UnsignedInteger8"]}, True|False}, LibraryDataType[NumericArray, "UnsignedInteger8"]];
imageLinkShrinkWidthMemoryFunc = LibraryFunctionLoad[$LibraryFile, "shrink_width_memory", {{LibraryDataType[NumericArray, "UnsignedInteger8"]}, Integer}, LibraryDataType[NumericArray, "UnsignedInteger8"]];
imageLinkDrawTextMemoryFunc = LibraryFunctionLoad[$LibraryFileDrawing, "draw_text_memory", {{LibraryDataType[NumericArray, "UnsignedInteger8"]}, Integer, Integer, Real, "UTF8String", "UTF8String", {LibraryDataType[NumericArray, "UnsignedInteger8"]}}, LibraryDataType[NumericArray, "UnsignedInteger8"]];
imageLinkFloodFillMemoryFunc = LibraryFunctionLoad[$LibraryFileDrawing, "flood_fill_memory", {{LibraryDataType[NumericArray, "UnsignedInteger8"]}, Integer, Integer, {LibraryDataType[NumericArray, "UnsignedInteger8"]}}, LibraryDataType[NumericArray, "UnsignedInteger8"]];
imageLinkDrawAALineMemoryFunc = LibraryFunctionLoad[$LibraryFileDrawing, "draw_antialiased_line_memory", {{LibraryDataType[NumericArray, "UnsignedInteger8"]}, Integer, Integer, Integer, Integer, {LibraryDataType[NumericArray, "UnsignedInteger8"]}}, LibraryDataType[NumericArray, "UnsignedInteger8"]];
imageLinkDrawBezierMemoryFunc = LibraryFunctionLoad[$LibraryFileDrawing, "draw_bezier_memory", {{LibraryDataType[NumericArray, "UnsignedInteger8"]}, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer, {LibraryDataType[NumericArray, "UnsignedInteger8"]}}, LibraryDataType[NumericArray, "UnsignedInteger8"]];
imageLinkHistogramMemoryFunc = LibraryFunctionLoad[$LibraryFileStats, "histogram_memory", {{LibraryDataType[NumericArray, "UnsignedInteger8"]}}, LibraryDataType[NumericArray, "UnsignedInteger32"]];
imageLinkPSNRMemoryFunc = LibraryFunctionLoad[$LibraryFileStats, "psnr_memory", {{LibraryDataType[NumericArray, "UnsignedInteger8"]}, {LibraryDataType[NumericArray, "UnsignedInteger8"]}}, Real];
imageLinkPHashMemoryFunc = LibraryFunctionLoad[$LibraryFileStats, "phash_memory", {{LibraryDataType[NumericArray, "UnsignedInteger8"]}}, Integer];
imageLinkOtsuLevelMemoryFunc = LibraryFunctionLoad[$LibraryFileStats, "otsu_level_memory", {{LibraryDataType[NumericArray, "UnsignedInteger8"]}}, Integer];
imageLinkKapurLevelMemoryFunc = LibraryFunctionLoad[$LibraryFileStats, "kapur_level_memory", {{LibraryDataType[NumericArray, "UnsignedInteger8"]}}, Integer];
imageLinkMatchHistogramMemoryFunc = LibraryFunctionLoad[$LibraryFileStats, "match_histogram_memory", {{LibraryDataType[NumericArray, "UnsignedInteger8"]}, {LibraryDataType[NumericArray, "UnsignedInteger8"]}}, LibraryDataType[NumericArray, "UnsignedInteger8"]];
imageLinkHoughLinesMemoryFunc = LibraryFunctionLoad[$LibraryFileGeometry, "hough_lines_memory", {{LibraryDataType[NumericArray, "UnsignedInteger8"]}, Integer, Integer}, LibraryDataType[NumericArray, "Real64"]];
imageLinkMorphologyOpenMemoryFunc = LibraryFunctionLoad[$LibraryFileGeometry, "morphology_open_memory", {{LibraryDataType[NumericArray, "UnsignedInteger8"]}, Integer, Integer}, LibraryDataType[NumericArray, "UnsignedInteger8"]];
imageLinkMorphologyCloseMemoryFunc = LibraryFunctionLoad[$LibraryFileGeometry, "morphology_close_memory", {{LibraryDataType[NumericArray, "UnsignedInteger8"]}, Integer, Integer}, LibraryDataType[NumericArray, "UnsignedInteger8"]];
imageLinkGeometryRotateAboutCenterMemoryFunc = LibraryFunctionLoad[$LibraryFileGeometry, "geometry_rotate_about_center_memory", {{LibraryDataType[NumericArray, "UnsignedInteger8"]}, Real, Integer}, LibraryDataType[NumericArray, "UnsignedInteger8"]];
imageLinkGeometryAffineMemoryFunc = LibraryFunctionLoad[$LibraryFileGeometry, "geometry_affine_memory", {{LibraryDataType[NumericArray, "UnsignedInteger8"]}, {LibraryDataType[NumericArray, "Real64"]}, Integer}, LibraryDataType[NumericArray, "UnsignedInteger8"]];

imageLinkGeometryFindContoursMemoryFunc = LibraryFunctionLoad[$LibraryFileGeometry, "geometry_find_contours_memory", {{LibraryDataType[NumericArray, "UnsignedInteger8"]}, Integer}, LibraryDataType[NumericArray, "Integer64"]];
imageLinkGeometryConvexHullMemoryFunc = LibraryFunctionLoad[$LibraryFileGeometry, "geometry_convex_hull_memory", {{LibraryDataType[NumericArray, "Integer64"]}}, LibraryDataType[NumericArray, "Integer64"]];
imageLinkGeometryMinAreaRectMemoryFunc = LibraryFunctionLoad[$LibraryFileGeometry, "geometry_min_area_rect_memory", {{LibraryDataType[NumericArray, "Integer64"]}}, LibraryDataType[NumericArray, "Integer64"]];
imageLinkGeometryApproximatePolygonDpMemoryFunc = LibraryFunctionLoad[$LibraryFileGeometry, "geometry_approximate_polygon_dp_memory", {{LibraryDataType[NumericArray, "Integer64"]}, Real, "Boolean"}, LibraryDataType[NumericArray, "Integer64"]];
imageLinkGeometryArcLengthMemoryFunc = LibraryFunctionLoad[$LibraryFileGeometry, "geometry_arc_length_memory", {{LibraryDataType[NumericArray, "Integer64"]}, "Boolean"}, Real];
imageLinkGeometryContourAreaMemoryFunc = LibraryFunctionLoad[$LibraryFileGeometry, "geometry_contour_area_memory", {{LibraryDataType[NumericArray, "Integer64"]}}, Real];

imageLinkCornersFast9MemoryFunc = LibraryFunctionLoad[$LibraryFileVision, "corners_fast9_memory", {{LibraryDataType[NumericArray, "UnsignedInteger8"]}, Integer}, LibraryDataType[NumericArray, "Integer64"]];
imageLinkCornersFast12MemoryFunc = LibraryFunctionLoad[$LibraryFileVision, "corners_fast12_memory", {{LibraryDataType[NumericArray, "UnsignedInteger8"]}, Integer}, LibraryDataType[NumericArray, "Integer64"]];
imageLinkMatchTemplateMemoryFunc = LibraryFunctionLoad[$LibraryFileVision, "match_template_memory", {{LibraryDataType[NumericArray, "UnsignedInteger8"]}, {LibraryDataType[NumericArray, "UnsignedInteger8"]}, Integer}, LibraryDataType[NumericArray, "Real64"]];
imageLinkDistanceTransformMemoryFunc = LibraryFunctionLoad[$LibraryFileVision, "distance_transform_memory", {{LibraryDataType[NumericArray, "UnsignedInteger8"]}, Integer}, LibraryDataType[NumericArray, "UnsignedInteger8"]];
imageLinkConnectedComponentsMemoryFunc = LibraryFunctionLoad[$LibraryFileVision, "connected_components_memory", {{LibraryDataType[NumericArray, "UnsignedInteger8"]}, Integer}, LibraryDataType[NumericArray, "UnsignedInteger32"]];
imageLinkHogMemoryFunc = LibraryFunctionLoad[$LibraryFileVision, "hog_memory", {{LibraryDataType[NumericArray, "UnsignedInteger8"]}, Integer, "Boolean", Integer, Integer, Integer}, LibraryDataType[NumericArray, "Real32"]];
imageLinkEvaluateHaarFeaturesMemoryFunc = LibraryFunctionLoad[$LibraryFileVision, "evaluate_haar_features_memory", {{LibraryDataType[NumericArray, "UnsignedInteger8"]}, Integer, Integer}, LibraryDataType[NumericArray, "Integer32"]];
imageLinkLocalBinaryPatternImageMemoryFunc = LibraryFunctionLoad[$LibraryFileVision, "local_binary_pattern_image_memory", {{LibraryDataType[NumericArray, "UnsignedInteger8"]}}, LibraryDataType[NumericArray, "UnsignedInteger8"]];
imageLinkSuppressNonMaximumMemoryFunc = LibraryFunctionLoad[$LibraryFileVision, "suppress_non_maximum_memory", {{LibraryDataType[NumericArray, "UnsignedInteger8"]}, Integer}, LibraryDataType[NumericArray, "UnsignedInteger8"]];

imageLinkSobelGradientsMemoryFunc = LibraryFunctionLoad[$LibraryFileVision, "sobel_gradients_memory", {{LibraryDataType[NumericArray, "UnsignedInteger8"]}}, LibraryDataType[NumericArray, "UnsignedInteger16"]];
imageLinkPrewittGradientsMemoryFunc = LibraryFunctionLoad[$LibraryFileVision, "prewitt_gradients_memory", {{LibraryDataType[NumericArray, "UnsignedInteger8"]}}, LibraryDataType[NumericArray, "UnsignedInteger16"]];
imageLinkHorizontalSobelMemoryFunc = LibraryFunctionLoad[$LibraryFileVision, "horizontal_sobel_memory", {{LibraryDataType[NumericArray, "UnsignedInteger8"]}}, LibraryDataType[NumericArray, "Integer16"]];
imageLinkVerticalSobelMemoryFunc = LibraryFunctionLoad[$LibraryFileVision, "vertical_sobel_memory", {{LibraryDataType[NumericArray, "UnsignedInteger8"]}}, LibraryDataType[NumericArray, "Integer16"]];
imageLinkHorizontalPrewittMemoryFunc = LibraryFunctionLoad[$LibraryFileVision, "horizontal_prewitt_memory", {{LibraryDataType[NumericArray, "UnsignedInteger8"]}}, LibraryDataType[NumericArray, "Integer16"]];
imageLinkVerticalPrewittMemoryFunc = LibraryFunctionLoad[$LibraryFileVision, "vertical_prewitt_memory", {{LibraryDataType[NumericArray, "UnsignedInteger8"]}}, LibraryDataType[NumericArray, "Integer16"]];
imageLinkHorizontalScharrMemoryFunc = LibraryFunctionLoad[$LibraryFileVision, "horizontal_scharr_memory", {{LibraryDataType[NumericArray, "UnsignedInteger8"]}}, LibraryDataType[NumericArray, "Integer16"]];
imageLinkVerticalScharrMemoryFunc = LibraryFunctionLoad[$LibraryFileVision, "vertical_scharr_memory", {{LibraryDataType[NumericArray, "UnsignedInteger8"]}}, LibraryDataType[NumericArray, "Integer16"]];

imageLinkFilterBilateralMemoryFunc = LibraryFunctionLoad[$LibraryFileFilter, "filter_bilateral_memory", {{LibraryDataType[NumericArray, "UnsignedInteger8"]}, Integer, Real, Real}, LibraryDataType[NumericArray, "UnsignedInteger8"]];
imageLinkFilterLaplacianMemoryFunc = LibraryFunctionLoad[$LibraryFileFilter, "filter_laplacian_memory", {{LibraryDataType[NumericArray, "UnsignedInteger8"]}}, LibraryDataType[NumericArray, "Integer16"]];
imageLinkFilterIntegralImageMemoryFunc = LibraryFunctionLoad[$LibraryFileFilter, "filter_integral_image_memory", {{LibraryDataType[NumericArray, "UnsignedInteger8"]}}, LibraryDataType[NumericArray, "UnsignedInteger32"]];
imageLinkFilterIntegralSquaredImageMemoryFunc = LibraryFunctionLoad[$LibraryFileFilter, "filter_integral_squared_image_memory", {{LibraryDataType[NumericArray, "UnsignedInteger8"]}}, LibraryDataType[NumericArray, "UnsignedInteger64"]];

ImageLinkVersion[] := imageLinkVersionFunc[]

Options[ImageLinkResize] = {Method -> "Triangle"}
Options[ImageLinkResizeMemory] = {Method -> "Triangle"}
Options[ImageLinkDrawRectangleMemory] = {Filled -> False}
Options[ImageLinkDrawCircleMemory] = {Filled -> False}
Options[ImageLinkDrawEllipseMemory] = {Filled -> False}
Options[ImageLinkDrawPolygonMemory] = {Filled -> False}

ImageLinkResize[input_String, output_String, {width_Integer, height_Integer}, OptionsPattern[]] := Module[{method},
  method = OptionValue[Method];
  imageLinkResizeFunc[ExpandFileName[input], ExpandFileName[output], width, height, method]
]

ImageLinkFlip[input_String, output_String, direction_String] := 
  imageLinkFlipFunc[ExpandFileName[input], ExpandFileName[output], direction]

ImageLinkRotate[input_String, output_String, angle_Integer] := 
  imageLinkRotateFunc[ExpandFileName[input], ExpandFileName[output], angle]

ImageLinkCrop[input_String, output_String, {x_Integer, y_Integer, w_Integer, h_Integer}] := 
  imageLinkCropFunc[ExpandFileName[input], ExpandFileName[output], x, y, w, h]

ImageLinkGrayscale[input_String, output_String] := 
  imageLinkGrayscaleFunc[ExpandFileName[input], ExpandFileName[output]]

ImageLinkInvert[input_String, output_String] := 
  imageLinkInvertFunc[ExpandFileName[input], ExpandFileName[output]]

ImageLinkBlur[input_String, output_String, sigma_?NumericQ] := 
  imageLinkBlurFunc[ExpandFileName[input], ExpandFileName[output], N[sigma]]

ImageLinkUnsharpen[input_String, output_String, sigma_?NumericQ, threshold_Integer] := 
  imageLinkUnsharpenFunc[ExpandFileName[input], ExpandFileName[output], N[sigma], threshold]

ImageLinkDimensions[input_String] := Module[{res},
  res = imageLinkDimensionsFunc[ExpandFileName[input]];
  If[StringContainsQ[res, "Error"],
    Message[ImageLinkDimensions::error, res]; $Failed,
    ToExpression["{" <> res <> "}"]
  ]
]

ImageLinkColorType[input_String] := imageLinkColorTypeFunc[ExpandFileName[input]]

ImageLinkBlurMemory[img_Image, sigma_?NumericQ] := Module[
  {na, res1d, dims},
  na = NumericArray[ImageData[img, "Byte"], "UnsignedInteger8"];
  dims = Dimensions[na];
  res1d = imageLinkBlurMemoryFunc[na, N[sigma]];
  Image[NumericArray[ArrayReshape[Normal[res1d], dims], "UnsignedInteger8"], "Byte", ColorSpace -> ImageColorSpace[img]]
]

ImageLinkInvertMemory[img_Image] := Module[
  {na, res1d, dims},
  na = NumericArray[ImageData[img, "Byte"], "UnsignedInteger8"];
  dims = Dimensions[na];
  res1d = imageLinkInvertMemoryFunc[na];
  Image[NumericArray[ArrayReshape[Normal[res1d], dims], "UnsignedInteger8"], "Byte", ColorSpace -> ImageColorSpace[img]]
]

ImageLinkUnsharpenMemory[img_Image, sigma_?NumericQ, threshold_Integer] := Module[
  {na, res1d, dims},
  na = NumericArray[ImageData[img, "Byte"], "UnsignedInteger8"];
  dims = Dimensions[na];
  res1d = imageLinkUnsharpenMemoryFunc[na, N[sigma], threshold];
  Image[NumericArray[ArrayReshape[Normal[res1d], dims], "UnsignedInteger8"], "Byte", ColorSpace -> ImageColorSpace[img]]
]

ImageLinkFlipMemory[img_Image, direction_String] := Module[
  {na, res1d, dims},
  na = NumericArray[ImageData[img, "Byte"], "UnsignedInteger8"];
  dims = Dimensions[na];
  res1d = imageLinkFlipMemoryFunc[na, direction];
  Image[NumericArray[ArrayReshape[Normal[res1d], dims], "UnsignedInteger8"], "Byte", ColorSpace -> ImageColorSpace[img]]
]

ImageLinkRotateMemory[img_Image, angle_Integer] := Module[
  {na, res1d, dims, newDims},
  na = NumericArray[ImageData[img, "Byte"], "UnsignedInteger8"];
  dims = Dimensions[na];
  res1d = imageLinkRotateMemoryFunc[na, angle];
  
  newDims = If[angle == 90 || angle == 270,
    {dims[[2]], dims[[1]], dims[[3]]},
    dims
  ];
  
  Image[NumericArray[ArrayReshape[Normal[res1d], newDims], "UnsignedInteger8"], "Byte", ColorSpace -> ImageColorSpace[img]]
]

ImageLinkGrayscaleMemory[img_Image] := Module[
  {na, res1d, dims, newDims},
  na = NumericArray[ImageData[img, "Byte"], "UnsignedInteger8"];
  dims = Dimensions[na];
  res1d = imageLinkGrayscaleMemoryFunc[na];
  
  newDims = {dims[[1]], dims[[2]], 1};
  
  Image[NumericArray[ArrayReshape[Normal[res1d], newDims], "UnsignedInteger8"], "Byte", ColorSpace -> "Grayscale"]
]

ImageLinkCropMemory[img_Image, {x_Integer, y_Integer, w_Integer, h_Integer}] := Module[
  {na, res1d, dims, newDims},
  na = NumericArray[ImageData[img, "Byte"], "UnsignedInteger8"];
  dims = Dimensions[na];
  res1d = imageLinkCropMemoryFunc[na, x, y, w, h];
  
  newDims = {h, w, dims[[3]]};
  
  Image[NumericArray[ArrayReshape[Normal[res1d], newDims], "UnsignedInteger8"], "Byte", ColorSpace -> ImageColorSpace[img]]
]

ImageLinkResizeMemory[img_Image, {width_Integer, height_Integer}, OptionsPattern[]] := Module[
  {na, res1d, dims, newDims, method},
  method = OptionValue[Method];
  na = NumericArray[ImageData[img, "Byte"], "UnsignedInteger8"];
  dims = Dimensions[na];
  res1d = imageLinkResizeMemoryFunc[na, width, height, method];
  
  newDims = {height, width, dims[[3]]};
  
  Image[NumericArray[ArrayReshape[Normal[res1d], newDims], "UnsignedInteger8"], "Byte", ColorSpace -> ImageColorSpace[img]]
]

ImageLinkCannyMemory[img_Image, low_?NumericQ, high_?NumericQ] := Module[
  {na, res1d, dims, newDims},
  na = NumericArray[ImageData[img, "Byte"], "UnsignedInteger8"];
  dims = Dimensions[na];
  res1d = imageLinkCannyMemoryFunc[na, N[low], N[high]];
  
  newDims = {dims[[1]], dims[[2]], 1};
  
  Image[NumericArray[ArrayReshape[Normal[res1d], newDims], "UnsignedInteger8"], "Byte", ColorSpace -> "Grayscale"]
]

ImageLinkDilateMemory[img_Image, radius_Integer] := Module[
  {na, res1d, dims},
  na = NumericArray[ImageData[img, "Byte"], "UnsignedInteger8"];
  dims = Dimensions[na];
  res1d = imageLinkDilateMemoryFunc[na, radius];
  
  Image[NumericArray[ArrayReshape[Normal[res1d], dims], "UnsignedInteger8"], "Byte", ColorSpace -> ImageColorSpace[img]]
]

ImageLinkErodeMemory[img_Image, radius_Integer] := Module[
  {na, res1d, dims},
  na = NumericArray[ImageData[img, "Byte"], "UnsignedInteger8"];
  dims = Dimensions[na];
  res1d = imageLinkErodeMemoryFunc[na, radius];
  
  Image[NumericArray[ArrayReshape[Normal[res1d], dims], "UnsignedInteger8"], "Byte", ColorSpace -> ImageColorSpace[img]]
]

ImageLinkMedianFilterMemory[img_Image, xRadius_Integer, yRadius_Integer] := Module[
  {na, res1d, dims},
  na = NumericArray[ImageData[img, "Byte"], "UnsignedInteger8"];
  dims = Dimensions[na];
  res1d = imageLinkMedianFilterMemoryFunc[na, xRadius, yRadius];
  
  Image[NumericArray[ArrayReshape[Normal[res1d], dims], "UnsignedInteger8"], "Byte", ColorSpace -> ImageColorSpace[img]]
]

ImageLinkFilter3x3Memory[img_Image, kernel_?MatrixQ] := Module[
  {na, res1d, dims, kernelNA},
  na = NumericArray[ImageData[img, "Byte"], "UnsignedInteger8"];
  dims = Dimensions[na];
  kernelNA = NumericArray[Flatten[N[kernel]], "Real64"];
  res1d = imageLinkFilter3x3MemoryFunc[na, kernelNA];
  
  Image[NumericArray[ArrayReshape[Normal[res1d], dims], "UnsignedInteger8"], "Byte", ColorSpace -> ImageColorSpace[img]]
]

ImageLinkEqualizeHistogramMemory[img_Image] := Module[
  {na, res1d, dims},
  na = NumericArray[ImageData[img, "Byte"], "UnsignedInteger8"];
  dims = Dimensions[na];
  res1d = imageLinkEqualizeHistogramMemoryFunc[na];
  
  Image[NumericArray[ArrayReshape[Normal[res1d], dims], "UnsignedInteger8"], "Byte", ColorSpace -> ImageColorSpace[img]]
]

ImageLinkAdaptiveThresholdMemory[img_Image, blockRadius_Integer, delta_Integer] := Module[
  {na, res1d, dims, newDims},
  na = NumericArray[ImageData[img, "Byte"], "UnsignedInteger8"];
  dims = Dimensions[na];
  res1d = imageLinkAdaptiveThresholdMemoryFunc[na, blockRadius, delta];
  
  newDims = {dims[[1]], dims[[2]], 1};
  
  Image[NumericArray[ArrayReshape[Normal[res1d], newDims], "UnsignedInteger8"], "Byte", ColorSpace -> "Grayscale"]
]

ImageLinkDrawLineMemory[img_Image, {x1_?NumericQ, y1_?NumericQ}, {x2_?NumericQ, y2_?NumericQ}, color_List] := Module[
  {na, res1d, dims, colorNA},
  na = NumericArray[ImageData[img, "Byte"], "UnsignedInteger8"];
  dims = Dimensions[na];
  colorNA = NumericArray[Round[color * 255], "UnsignedInteger8"];
  res1d = imageLinkDrawLineMemoryFunc[na, N[x1], N[y1], N[x2], N[y2], colorNA];
  
  Image[NumericArray[ArrayReshape[Normal[res1d], dims], "UnsignedInteger8"], "Byte", ColorSpace -> ImageColorSpace[img]]
]

ImageLinkDrawRectangleMemory[img_Image, {x_Integer, y_Integer, w_Integer, h_Integer}, color_List, OptionsPattern[]] := Module[
  {na, res1d, dims, colorNA, filled},
  na = NumericArray[ImageData[img, "Byte"], "UnsignedInteger8"];
  dims = Dimensions[na];
  colorNA = NumericArray[Round[color * 255], "UnsignedInteger8"];
  filled = TrueQ[OptionValue[Filled]];
  res1d = imageLinkDrawRectMemoryFunc[na, x, y, w, h, colorNA, filled];
  
  Image[NumericArray[ArrayReshape[Normal[res1d], dims], "UnsignedInteger8"], "Byte", ColorSpace -> ImageColorSpace[img]]
]

ImageLinkDrawCircleMemory[img_Image, {x_Integer, y_Integer}, radius_Integer, color_List, OptionsPattern[]] := Module[
  {na, res1d, dims, colorNA, filled},
  na = NumericArray[ImageData[img, "Byte"], "UnsignedInteger8"];
  dims = Dimensions[na];
  colorNA = NumericArray[Round[color * 255], "UnsignedInteger8"];
  filled = TrueQ[OptionValue[Filled]];
  res1d = imageLinkDrawCircleMemoryFunc[na, x, y, radius, colorNA, filled];
  
  Image[NumericArray[ArrayReshape[Normal[res1d], dims], "UnsignedInteger8"], "Byte", ColorSpace -> ImageColorSpace[img]]
]

ImageLinkDrawEllipseMemory[img_Image, {x_Integer, y_Integer}, {rx_Integer, ry_Integer}, color_List, OptionsPattern[]] := Module[
  {na, res1d, dims, colorNA, filled},
  na = NumericArray[ImageData[img, "Byte"], "UnsignedInteger8"];
  dims = Dimensions[na];
  colorNA = NumericArray[Round[color * 255], "UnsignedInteger8"];
  filled = TrueQ[OptionValue[Filled]];
  res1d = imageLinkDrawEllipseMemoryFunc[na, x, y, rx, ry, colorNA, filled];
  
  Image[NumericArray[ArrayReshape[Normal[res1d], dims], "UnsignedInteger8"], "Byte", ColorSpace -> ImageColorSpace[img]]
]

ImageLinkDrawPolygonMemory[img_Image, points:{{_Integer, _Integer}..}, color_List, OptionsPattern[]] := Module[
  {na, res1d, dims, colorNA, filled, pxNA, pyNA},
  na = NumericArray[ImageData[img, "Byte"], "UnsignedInteger8"];
  dims = Dimensions[na];
  colorNA = NumericArray[Round[color * 255], "UnsignedInteger8"];
  filled = TrueQ[OptionValue[Filled]];
  pxNA = NumericArray[points[[All, 1]], "Integer64"];
  pyNA = NumericArray[points[[All, 2]], "Integer64"];
  res1d = imageLinkDrawPolygonMemoryFunc[na, pxNA, pyNA, colorNA, filled];
  
  Image[NumericArray[ArrayReshape[Normal[res1d], dims], "UnsignedInteger8"], "Byte", ColorSpace -> ImageColorSpace[img]]
]

ImageLinkShrinkWidthMemory[img_Image, targetWidth_Integer] := Module[
  {na, res1d, dims},
  na = NumericArray[ImageData[img, "Byte"], "UnsignedInteger8"];
  dims = Dimensions[na];
  
  If[targetWidth >= dims[[2]], Return[img]];

  res1d = imageLinkShrinkWidthMemoryFunc[na, targetWidth];
  
  Image[NumericArray[ArrayReshape[Normal[res1d], {dims[[1]], targetWidth, dims[[3]]}], "UnsignedInteger8"], "Byte", ColorSpace -> ImageColorSpace[img]]
]

ImageLinkDrawTextMemory[img_Image, text_String, {x_Integer, y_Integer}, scale_?NumericQ, fontPath_String, color_List] := Module[
  {na, res1d, dims, colorNA},
  na = NumericArray[ImageData[img, "Byte"], "UnsignedInteger8"];
  dims = Dimensions[na];
  colorNA = NumericArray[Round[color * 255], "UnsignedInteger8"];
  res1d = imageLinkDrawTextMemoryFunc[na, x, y, N[scale], ExpandFileName[fontPath], text, colorNA];
  Image[NumericArray[ArrayReshape[Normal[res1d], dims], "UnsignedInteger8"], "Byte", ColorSpace -> ImageColorSpace[img]]
]

ImageLinkFloodFillMemory[img_Image, {x_Integer, y_Integer}, color_List] := Module[
  {na, res1d, dims, colorNA},
  na = NumericArray[ImageData[img, "Byte"], "UnsignedInteger8"];
  dims = Dimensions[na];
  colorNA = NumericArray[Round[color * 255], "UnsignedInteger8"];
  res1d = imageLinkFloodFillMemoryFunc[na, x, y, colorNA];
  Image[NumericArray[ArrayReshape[Normal[res1d], dims], "UnsignedInteger8"], "Byte", ColorSpace -> ImageColorSpace[img]]
]

ImageLinkDrawAntialiasedLineMemory[img_Image, {x1_Integer, y1_Integer}, {x2_Integer, y2_Integer}, color_List] := Module[
  {na, res1d, dims, colorNA},
  na = NumericArray[ImageData[img, "Byte"], "UnsignedInteger8"];
  dims = Dimensions[na];
  colorNA = NumericArray[Round[color * 255], "UnsignedInteger8"];
  res1d = imageLinkDrawAALineMemoryFunc[na, x1, y1, x2, y2, colorNA];
  Image[NumericArray[ArrayReshape[Normal[res1d], dims], "UnsignedInteger8"], "Byte", ColorSpace -> ImageColorSpace[img]]
]

ImageLinkDrawBezierMemory[img_Image, {{x1_, y1_}, {x2_, y2_}, {x3_, y3_}, {x4_, y4_}}, color_List] := Module[
  {na, res1d, dims, colorNA},
  na = NumericArray[ImageData[img, "Byte"], "UnsignedInteger8"];
  dims = Dimensions[na];
  colorNA = NumericArray[Round[color * 255], "UnsignedInteger8"];
  res1d = imageLinkDrawBezierMemoryFunc[na, Round[x1], Round[y1], Round[x2], Round[y2], Round[x3], Round[y3], Round[x4], Round[y4], colorNA];
  Image[NumericArray[ArrayReshape[Normal[res1d], dims], "UnsignedInteger8"], "Byte", ColorSpace -> ImageColorSpace[img]]
]

ImageLinkHistogramMemory[img_Image] := Module[
  {na, res1d, dims, channels},
  na = NumericArray[ImageData[img, "Byte"], "UnsignedInteger8"];
  dims = Dimensions[na];
  channels = dims[[3]];
  res1d = imageLinkHistogramMemoryFunc[na];
  ArrayReshape[Normal[res1d], {channels, 256}]
]

ImageLinkPSNRMemory[img1_Image, img2_Image] := Module[
  {na1, na2},
  na1 = NumericArray[ImageData[img1, "Byte"], "UnsignedInteger8"];
  na2 = NumericArray[ImageData[img2, "Byte"], "UnsignedInteger8"];
  imageLinkPSNRMemoryFunc[na1, na2]
]

ImageLinkPHashMemory[img_Image] := Module[
  {na},
  na = NumericArray[ImageData[img, "Byte"], "UnsignedInteger8"];
  imageLinkPHashMemoryFunc[na]
]

ImageLinkOtsuLevelMemory[img_Image] := Module[{data},
  data = ImageData[img, "Byte"];
  imageLinkOtsuLevelMemoryFunc[NumericArray[data, "UnsignedInteger8"]]
];

ImageLinkKapurLevelMemory[img_Image] := Module[{data},
  data = ImageData[img, "Byte"];
  imageLinkKapurLevelMemoryFunc[NumericArray[data, "UnsignedInteger8"]]
];

ImageLinkMatchHistogramMemory[img_Image, target_Image] := Module[{data, targetData},
  data = ImageData[img, "Byte"];
  targetData = ImageData[target, "Byte"];
  Image[Normal[imageLinkMatchHistogramMemoryFunc[NumericArray[data, "UnsignedInteger8"], NumericArray[targetData, "UnsignedInteger8"]]], "Byte"]
];

ImageLinkHoughLinesMemory[img_Image, voteThreshold_Integer: 10, suppressionRadius_Integer: 8] := Module[{data, result},
  data = ImageData[img, "Byte"];
  result = imageLinkHoughLinesMemoryFunc[NumericArray[data, "UnsignedInteger8"], voteThreshold, suppressionRadius];
  Normal[result]
];

ImageLinkMorphologyOpenMemory[img_Image, norm_Integer: 1, k_Integer: 1] := Module[{data},
  data = ImageData[img, "Byte"];
  Image[Normal[imageLinkMorphologyOpenMemoryFunc[NumericArray[data, "UnsignedInteger8"], norm, k]], "Byte"]
];

ImageLinkMorphologyCloseMemory[img_Image, norm_Integer: 1, k_Integer: 1] := Module[{data},
  data = ImageData[img, "Byte"];
  Image[Normal[imageLinkMorphologyCloseMemoryFunc[NumericArray[data, "UnsignedInteger8"], norm, k]], "Byte"]
];

ImageLinkRotateAboutCenterMemory[img_Image, theta_Real, interpolation_Integer: 2] := Module[{data},
  data = ImageData[img, "Byte"];
  Image[Normal[imageLinkGeometryRotateAboutCenterMemoryFunc[NumericArray[data, "UnsignedInteger8"], theta, interpolation]], "Byte"]
];

ImageLinkAffineMemory[img_Image, matrix_?MatrixQ, interpolation_Integer: 2] := Module[{data, mat},
  data = ImageData[img, "Byte"];
  mat = NumericArray[matrix, "Real64"];
  Image[Normal[imageLinkGeometryAffineMemoryFunc[NumericArray[data, "UnsignedInteger8"], mat, interpolation]], "Byte"]
];

ImageLinkCornersFast9Memory[img_Image, threshold_Integer: 10] := Module[{data},
  data = ImageData[img, "Byte"];
  Normal[imageLinkCornersFast9MemoryFunc[NumericArray[data, "UnsignedInteger8"], threshold]]
];

ImageLinkMatchTemplateMemory[img_Image, template_Image, method_Integer: 4] := Module[{data, targetData},
  data = ImageData[img, "Byte"];
  targetData = ImageData[template, "Byte"];
  Image[Normal[imageLinkMatchTemplateMemoryFunc[NumericArray[data, "UnsignedInteger8"], NumericArray[targetData, "UnsignedInteger8"], method]]]
];

ImageLinkDistanceTransformMemory[img_Image, norm_Integer: 1] := Module[{data},
  data = ImageData[img, "Byte"];
  Image[Normal[imageLinkDistanceTransformMemoryFunc[NumericArray[data, "UnsignedInteger8"], norm]], "Byte"]
];

ImageLinkFindContoursMemory[img_Image, threshold_Integer] := Module[
  {na, res, numContours, idx, contours, pLen, bType, pIdx, pts},
  na = NumericArray[ImageData[img, "Byte"], "UnsignedInteger8"];
  res = Normal[imageLinkGeometryFindContoursMemoryFunc[na, threshold]];
  If[Length[res] == 0, Return[{}]];
  numContours = res[[1]];
  idx = 2;
  contours = Table[
    pLen = res[[idx]];
    bType = If[res[[idx+1]] == 0, "Outer", "Hole"];
    pIdx = res[[idx+2]];
    idx += 3;
    pts = Partition[res[[idx ;; idx + pLen * 2 - 1]], 2];
    idx += pLen * 2;
    <|"Points" -> pts, "BorderType" -> bType, "Parent" -> pIdx|>,
    {i, 1, numContours}
  ];
  contours
]

ImageLinkConvexHullMemory[points_List] := Module[
  {na, res},
  na = NumericArray[Flatten[points], "Integer64"];
  res = Normal[imageLinkGeometryConvexHullMemoryFunc[na]];
  Partition[res, 2]
]

ImageLinkMinAreaRectMemory[points_List] := Module[
  {na, res},
  na = NumericArray[Flatten[points], "Integer64"];
  res = Normal[imageLinkGeometryMinAreaRectMemoryFunc[na]];
  Partition[res, 2]
]

ImageLinkApproximatePolygonMemory[points_List, epsilon_?NumericQ, closed:(True|False):True] := Module[
  {na, res},
  na = NumericArray[Flatten[points], "Integer64"];
  res = Normal[imageLinkGeometryApproximatePolygonDpMemoryFunc[na, N[epsilon], closed]];
  Partition[res, 2]
]

ImageLinkArcLengthMemory[points_List, closed:(True|False):True] := Module[
  {na},
  na = NumericArray[Flatten[points], "Integer64"];
  imageLinkGeometryArcLengthMemoryFunc[na, closed]
]

ImageLinkContourAreaMemory[points_List] := Module[
  {na},
  na = NumericArray[Flatten[points], "Integer64"];
  imageLinkGeometryContourAreaMemoryFunc[na]
]

ImageLinkSobelGradientsMemory[img_Image] := Module[{data, res},
  data = ImageData[img, "Byte"];
  res = imageLinkSobelGradientsMemoryFunc[NumericArray[data, "UnsignedInteger8"]];
  Image[Normal[res], "Bit16"]
];

ImageLinkPrewittGradientsMemory[img_Image] := Module[{data, res},
  data = ImageData[img, "Byte"];
  res = imageLinkPrewittGradientsMemoryFunc[NumericArray[data, "UnsignedInteger8"]];
  Image[Normal[res], "Bit16"]
];

ImageLinkHorizontalSobelMemory[img_Image] := Module[{data},
  data = ImageData[img, "Byte"];
  Normal[imageLinkHorizontalSobelMemoryFunc[NumericArray[data, "UnsignedInteger8"]]]
];

ImageLinkVerticalSobelMemory[img_Image] := Module[{data},
  data = ImageData[img, "Byte"];
  Normal[imageLinkVerticalSobelMemoryFunc[NumericArray[data, "UnsignedInteger8"]]]
];

ImageLinkHorizontalPrewittMemory[img_Image] := Module[{data},
  data = ImageData[img, "Byte"];
  Normal[imageLinkHorizontalPrewittMemoryFunc[NumericArray[data, "UnsignedInteger8"]]]
];

ImageLinkVerticalPrewittMemory[img_Image] := Module[{data},
  data = ImageData[img, "Byte"];
  Normal[imageLinkVerticalPrewittMemoryFunc[NumericArray[data, "UnsignedInteger8"]]]
];

ImageLinkHorizontalScharrMemory[img_Image] := Module[{data},
  data = ImageData[img, "Byte"];
  Normal[imageLinkHorizontalScharrMemoryFunc[NumericArray[data, "UnsignedInteger8"]]]
];

ImageLinkVerticalScharrMemory[img_Image] := Module[{data},
  data = ImageData[img, "Byte"];
  Normal[imageLinkVerticalScharrMemoryFunc[NumericArray[data, "UnsignedInteger8"]]]
];

ImageLinkCornersFast12Memory[img_Image, threshold_Integer: 10] := Module[{data, res},
  data = ImageData[img, "Byte"];
  res = Normal[imageLinkCornersFast12MemoryFunc[NumericArray[data, "UnsignedInteger8"], threshold]];
  Partition[res, 2]
];

ImageLinkConnectedComponentsMemory[img_Image, connectivity_Integer: 8] := Module[{data, res, dims},
  data = ImageData[img, "Byte"];
  res = imageLinkConnectedComponentsMemoryFunc[NumericArray[data, "UnsignedInteger8"], connectivity];
  dims = Dimensions[img];
  Image[NumericArray[ArrayReshape[Normal[res], Reverse[dims[[1;;2]]]], "UnsignedInteger32"], "Bit32"]
];

ImageLinkHogMemory[img_Image, orientations_Integer: 8, signed:(True|False):True, cellSide_Integer: 8, blockSide_Integer: 2, blockStride_Integer: 1] := Module[{data},
  data = ImageData[img, "Byte"];
  Normal[imageLinkHogMemoryFunc[NumericArray[data, "UnsignedInteger8"], orientations, signed, cellSide, blockSide, blockStride]]
];

ImageLinkBilateralFilterMemory[img_Image, radius_Integer, sigmaSpatial_?NumericQ, sigmaColor_?NumericQ] := Module[{data},
  data = ImageData[img, "Byte"];
  Image[Normal[imageLinkFilterBilateralMemoryFunc[NumericArray[data, "UnsignedInteger8"], radius, N[sigmaSpatial], N[sigmaColor]]], "Byte"]
]

ImageLinkLaplacianFilterMemory[img_Image] := Module[{data},
  data = ImageData[img, "Byte"];
  imageLinkFilterLaplacianMemoryFunc[NumericArray[data, "UnsignedInteger8"]]
]

ImageLinkIntegralImageMemory[img_Image] := Module[{data},
  data = ImageData[img, "Byte"];
  Normal[imageLinkFilterIntegralImageMemoryFunc[NumericArray[data, "UnsignedInteger8"]]]
]

ImageLinkIntegralSquaredImageMemory[img_Image] := Module[{data},
  data = ImageData[img, "Byte"];
  Normal[imageLinkFilterIntegralSquaredImageMemoryFunc[NumericArray[data, "UnsignedInteger8"]]]
]

ImageLinkEvaluateHaarFeaturesMemory[img_Image, frameWidth_Integer, frameHeight_Integer] := Module[{data},
  data = ImageData[img, "Byte"];
  Normal[imageLinkEvaluateHaarFeaturesMemoryFunc[NumericArray[data, "UnsignedInteger8"], frameWidth, frameHeight]]
]

ImageLinkLocalBinaryPatternMemory[img_Image] := Module[{data},
  data = ImageData[img, "Byte"];
  Image[Normal[imageLinkLocalBinaryPatternImageMemoryFunc[NumericArray[data, "UnsignedInteger8"]]], "Byte"]
]

ImageLinkSuppressNonMaximumMemory[img_Image, radius_Integer] := Module[{data},
  data = ImageData[img, "Byte"];
  Image[Normal[imageLinkSuppressNonMaximumMemoryFunc[NumericArray[data, "UnsignedInteger8"], radius]], "Byte"]
]

End[]
EndPackage[]
