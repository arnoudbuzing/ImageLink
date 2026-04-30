AppendTo[$Path, ExpandFileName[Directory[] <> "/../"]];
<<ImageLink`
Print["Starting test_geometry_contours.wl"];

img = Image[Table[If[(i-50)^2 + (j-50)^2 < 400, 255, 0], {i, 100}, {j, 100}], "Byte"]
contours = ImageLinkFindContoursMemory[img, 128]
Print["Found ", Length[contours], " contours."];

If[Length[contours] > 0,
  pts = contours[[1]]["Points"];
  Print["Number of points in first contour: ", Length[pts]];

  hull = ImageLinkConvexHullMemory[pts];
  Print["Convex hull points: ", Length[hull]];

  rect = ImageLinkMinAreaRectMemory[pts];
  Print["Min area rect corners: ", rect];

  approx = ImageLinkApproximatePolygonMemory[pts, 5.0, True];
  Print["Approximate polygon points: ", Length[approx]];

  arcLen = ImageLinkArcLengthMemory[pts, True];
  Print["Arc length: ", arcLen];

  area = ImageLinkContourAreaMemory[pts];
  Print["Contour area: ", area];
];

Print["Done!"];
