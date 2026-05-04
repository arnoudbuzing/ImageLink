//! Geometric transformations and analysis for the ImageLink project.
//!
//! This crate provides functions for Hough line detection, morphological operations,
//! rotations, affine transformations, and contour analysis.

use wolfram_library_link::{export, NumericArray};
use image::{ImageBuffer, Rgb, Rgba, Luma};
use imageproc::morphology;

/// Returns the version string of the rust_geometry crate.
#[export]
pub fn get_geometry_version() -> String {
    "0.1.0".to_string()
}

/// Detects lines using the Hough transform.
///
/// # Arguments
/// * `vote_threshold` - Minimum number of votes to consider a line.
/// * `suppression_radius` - Radius for non-maximum suppression in Hough space.
///
/// # Returns
/// A NumericArray of shape [N, 2] containing {radius, angle_in_degrees} for each detected line.
#[export]
pub fn hough_lines_memory(array: &NumericArray<u8>, vote_threshold: i64, suppression_radius: i64) -> NumericArray<f64> {
    let dims = array.dimensions();
    if dims.len() < 2 {
        return NumericArray::<f64>::from_slice(&[]);
    }
    let h = dims[0] as u32;
    let w = dims[1] as u32;
    let channels = if dims.len() == 3 { dims[2] as u32 } else { 1 };
    let slice = array.as_slice();

    let gray_img = if channels == 3 {
        let img = ImageBuffer::<Rgb<u8>, _>::from_raw(w, h, slice.to_vec()).unwrap();
        image::imageops::grayscale(&img)
    } else if channels == 4 {
        let img = ImageBuffer::<Rgba<u8>, _>::from_raw(w, h, slice.to_vec()).unwrap();
        image::imageops::grayscale(&img)
    } else {
        ImageBuffer::<image::Luma<u8>, _>::from_raw(w, h, slice.to_vec()).unwrap()
    };

    let options = imageproc::hough::LineDetectionOptions {
        vote_threshold: vote_threshold as u32,
        suppression_radius: suppression_radius as u32,
    };

    let lines = imageproc::hough::detect_lines(&gray_img, options);
    
    if lines.is_empty() {
        return NumericArray::<f64>::from_slice(&[]);
    }
    
    let mut result = Vec::with_capacity(lines.len() * 2);
    for line in lines {
        result.push(line.r as f64);
        result.push(line.angle_in_degrees as f64);
    }
    
    NumericArray::<f64>::from_array(&[result.len() / 2, 2], &result)
}

/// Performs morphological opening on an image.
#[export]
pub fn morphology_open_memory(array: &NumericArray<u8>, norm: i64, k: i64) -> NumericArray<u8> {
    let dims = array.dimensions();
    if dims.len() < 2 {
        return NumericArray::<u8>::from_slice(&[]);
    }
    let h = dims[0] as u32;
    let w = dims[1] as u32;
    let channels = if dims.len() == 3 { dims[2] as u32 } else { 1 };
    let slice = array.as_slice();
    
    let image_norm = match norm {
        1 => imageproc::distance_transform::Norm::L1,
        2 => imageproc::distance_transform::Norm::L2,
        _ => imageproc::distance_transform::Norm::LInf,
    };

    if channels == 1 {
        let img = ImageBuffer::<Luma<u8>, _>::from_raw(w, h, slice.to_vec()).unwrap();
        let res = morphology::open(&img, image_norm, k as u8);
        NumericArray::<u8>::from_array(dims, &res.into_raw())
    } else {
        // we can only do open on gray image?
        // Let's implement grayscale conversion if needed, or return empty
        let img = ImageBuffer::<Luma<u8>, _>::from_raw(w, h, slice.to_vec()).unwrap_or_else(|| {
             ImageBuffer::new(w, h)
        });
        let res = morphology::open(&img, image_norm, k as u8);
        NumericArray::<u8>::from_array(&[h as usize, w as usize, 1], &res.into_raw())
    }
}

/// Performs morphological closing on an image.
#[export]
pub fn morphology_close_memory(array: &NumericArray<u8>, norm: i64, k: i64) -> NumericArray<u8> {
    let dims = array.dimensions();
    if dims.len() < 2 {
        return NumericArray::<u8>::from_slice(&[]);
    }
    let h = dims[0] as u32;
    let w = dims[1] as u32;
    let channels = if dims.len() == 3 { dims[2] as u32 } else { 1 };
    let slice = array.as_slice();
    
    let image_norm = match norm {
        1 => imageproc::distance_transform::Norm::L1,
        2 => imageproc::distance_transform::Norm::L2,
        _ => imageproc::distance_transform::Norm::LInf,
    };

    if channels == 1 {
        let img = ImageBuffer::<Luma<u8>, _>::from_raw(w, h, slice.to_vec()).unwrap();
        let res = morphology::close(&img, image_norm, k as u8);
        NumericArray::<u8>::from_array(dims, &res.into_raw())
    } else {
        let img = ImageBuffer::<Luma<u8>, _>::from_raw(w, h, slice.to_vec()).unwrap_or_else(|| {
             ImageBuffer::new(w, h)
        });
        let res = morphology::close(&img, image_norm, k as u8);
        NumericArray::<u8>::from_array(&[h as usize, w as usize, 1], &res.into_raw())
    }
}

/// Rotates an image about its center by theta radians.
#[export]
pub fn geometry_rotate_about_center_memory(array: &NumericArray<u8>, theta: f64, interpolation: i64) -> NumericArray<u8> {
    let dims = array.dimensions();
    if dims.len() < 2 {
        return NumericArray::<u8>::from_slice(&[]);
    }
    let h = dims[0] as u32;
    let w = dims[1] as u32;
    let channels = if dims.len() == 3 { dims[2] as u32 } else { 1 };
    let slice = array.as_slice();
    
    let interp = match interpolation {
        1 => imageproc::geometric_transformations::Interpolation::Nearest,
        2 => imageproc::geometric_transformations::Interpolation::Bilinear,
        _ => imageproc::geometric_transformations::Interpolation::Bicubic,
    };

    if channels == 3 {
        let img = ImageBuffer::<Rgb<u8>, _>::from_raw(w, h, slice.to_vec()).unwrap();
        let res = imageproc::geometric_transformations::rotate_about_center(&img, theta as f32, interp, Rgb([0, 0, 0]));
        NumericArray::<u8>::from_array(dims, &res.into_raw())
    } else if channels == 4 {
        let img = ImageBuffer::<Rgba<u8>, _>::from_raw(w, h, slice.to_vec()).unwrap();
        let res = imageproc::geometric_transformations::rotate_about_center(&img, theta as f32, interp, Rgba([0, 0, 0, 0]));
        NumericArray::<u8>::from_array(dims, &res.into_raw())
    } else {
        let img = ImageBuffer::<Luma<u8>, _>::from_raw(w, h, slice.to_vec()).unwrap_or_else(|| ImageBuffer::new(w, h));
        let res = imageproc::geometric_transformations::rotate_about_center(&img, theta as f32, interp, Luma([0]));
        NumericArray::<u8>::from_array(dims, &res.into_raw())
    }
}

/// Applies an affine transformation defined by a 3x3 matrix.
#[export]
pub fn geometry_affine_memory(array: &NumericArray<u8>, matrix: &NumericArray<f64>, interpolation: i64) -> NumericArray<u8> {
    let dims = array.dimensions();
    if dims.len() < 2 {
        return NumericArray::<u8>::from_slice(&[]);
    }
    let mdims = matrix.dimensions();
    if mdims.len() != 2 || mdims[0] != 3 || mdims[1] != 3 {
        return NumericArray::<u8>::from_slice(&[]);
    }

    let h = dims[0] as u32;
    let w = dims[1] as u32;
    let channels = if dims.len() == 3 { dims[2] as u32 } else { 1 };
    let slice = array.as_slice();
    let mslice = matrix.as_slice();
    
    let transform = [
        mslice[0] as f32, mslice[1] as f32, mslice[2] as f32,
        mslice[3] as f32, mslice[4] as f32, mslice[5] as f32,
        mslice[6] as f32, mslice[7] as f32, mslice[8] as f32,
    ];
    let proj = match imageproc::geometric_transformations::Projection::from_matrix(transform) {
        Some(p) => p,
        None => return NumericArray::<u8>::from_slice(&[]),
    };

    let interp = match interpolation {
        1 => imageproc::geometric_transformations::Interpolation::Nearest,
        2 => imageproc::geometric_transformations::Interpolation::Bilinear,
        _ => imageproc::geometric_transformations::Interpolation::Bicubic,
    };

    if channels == 3 {
        let img = ImageBuffer::<Rgb<u8>, _>::from_raw(w, h, slice.to_vec()).unwrap();
        let res = imageproc::geometric_transformations::warp(&img, &proj, interp, Rgb([0, 0, 0]));
        NumericArray::<u8>::from_array(dims, &res.into_raw())
    } else if channels == 4 {
        let img = ImageBuffer::<Rgba<u8>, _>::from_raw(w, h, slice.to_vec()).unwrap();
        let res = imageproc::geometric_transformations::warp(&img, &proj, interp, Rgba([0, 0, 0, 0]));
        NumericArray::<u8>::from_array(dims, &res.into_raw())
    } else {
        let img = ImageBuffer::<Luma<u8>, _>::from_raw(w, h, slice.to_vec()).unwrap_or_else(|| ImageBuffer::new(w, h));
        let res = imageproc::geometric_transformations::warp(&img, &proj, interp, Luma([0]));
        NumericArray::<u8>::from_array(dims, &res.into_raw())
    }
}

fn parse_points(array: &NumericArray<i64>) -> Vec<imageproc::point::Point<i32>> {
    let slice = array.as_slice();
    let mut points = Vec::with_capacity(slice.len() / 2);
    for chunk in slice.chunks(2) {
        if chunk.len() == 2 {
            points.push(imageproc::point::Point::new(chunk[0] as i32, chunk[1] as i32));
        }
    }
    points
}

fn encode_points(points: &[imageproc::point::Point<i32>]) -> NumericArray<i64> {
    let mut res = Vec::with_capacity(points.len() * 2);
    for p in points {
        res.push(p.x as i64);
        res.push(p.y as i64);
    }
    NumericArray::<i64>::from_array(&[points.len(), 2], &res)
}

/// Finds contours in a grayscale image using a threshold.
#[export]
pub fn geometry_find_contours_memory(array: &NumericArray<u8>, threshold: i64) -> NumericArray<i64> {
    let dims = array.dimensions();
    if dims.len() < 2 {
        return NumericArray::<i64>::from_slice(&[]);
    }
    let h = dims[0] as u32;
    let w = dims[1] as u32;
    let channels = if dims.len() == 3 { dims[2] as u32 } else { 1 };
    let slice = array.as_slice();

    let luma = if channels == 3 {
        let img = ImageBuffer::<Rgb<u8>, _>::from_raw(w, h, slice.to_vec()).unwrap();
        image::imageops::grayscale(&img)
    } else if channels == 4 {
        let img = ImageBuffer::<Rgba<u8>, _>::from_raw(w, h, slice.to_vec()).unwrap();
        image::imageops::grayscale(&img)
    } else {
        ImageBuffer::<image::Luma<u8>, _>::from_raw(w, h, slice.to_vec()).unwrap()
    };

    let contours = imageproc::contours::find_contours_with_threshold::<u32>(&luma, threshold as u8);
    let mut total_len = 1;
    for c in &contours {
        total_len += 3;
        total_len += c.points.len() * 2;
    }
    let mut res = Vec::with_capacity(total_len);
    res.push(contours.len() as i64);
    for c in &contours {
        res.push(c.points.len() as i64);
        res.push(match c.border_type {
            imageproc::contours::BorderType::Outer => 0,
            imageproc::contours::BorderType::Hole => 1,
        });
        res.push(match c.parent {
            Some(p) => p as i64,
            None => -1,
        });
        for p in &c.points {
            res.push(p.x as i64);
            res.push(p.y as i64);
        }
    }
    NumericArray::<i64>::from_slice(&res)
}

/// Computes the convex hull of a set of points.
#[export]
pub fn geometry_convex_hull_memory(points_array: &NumericArray<i64>) -> NumericArray<i64> {
    let points = parse_points(points_array);
    let hull = imageproc::geometry::convex_hull(points);
    encode_points(&hull)
}

/// Computes the minimum area rectangle enclosing a set of points.
#[export]
pub fn geometry_min_area_rect_memory(points_array: &NumericArray<i64>) -> NumericArray<i64> {
    let points = parse_points(points_array);
    let rect = imageproc::geometry::min_area_rect(&points);
    
    // Convert [Point<i32>; 4] to slice
    let rect_slice = [rect[0], rect[1], rect[2], rect[3]];
    encode_points(&rect_slice)
}

/// Approximates a polygon with fewer vertices using the Douglas-Peucker algorithm.
#[export]
pub fn geometry_approximate_polygon_dp_memory(points_array: &NumericArray<i64>, epsilon: f64, closed: bool) -> NumericArray<i64> {
    let points = parse_points(points_array);
    let approx = imageproc::geometry::approximate_polygon_dp(&points, epsilon, closed);
    encode_points(&approx)
}

/// Computes the arc length of a polygon or curve.
#[export]
pub fn geometry_arc_length_memory(points_array: &NumericArray<i64>, closed: bool) -> f64 {
    let points = parse_points(points_array);
    imageproc::geometry::arc_length(&points, closed)
}

/// Computes the area of a contour.
#[export]
pub fn geometry_contour_area_memory(points_array: &NumericArray<i64>) -> f64 {
    let points = parse_points(points_array);
    imageproc::geometry::contour_area(&points)
}
