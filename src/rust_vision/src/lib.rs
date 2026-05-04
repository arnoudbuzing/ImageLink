//! Computer vision algorithms for the ImageLink project.
//!
//! This crate provides high-performance vision primitives such as corner detection,
//! template matching, and feature extraction, exported for use in the Wolfram Language.

use wolfram_library_link::{export, NumericArray};
use image::{ImageBuffer, Rgb, Rgba};

/// Internal utility to convert a NumericArray to a Luma (grayscale) ImageBuffer.
///
/// Supports 3-channel (RGB), 4-channel (RGBA), and 1-channel (Luma) inputs.
fn to_luma(array: &NumericArray<u8>) -> Option<ImageBuffer<image::Luma<u8>, Vec<u8>>> {
    let dims = array.dimensions();
    if dims.len() < 2 { return None; }
    let h = dims[0] as u32;
    let w = dims[1] as u32;
    let ch = if dims.len() == 3 { dims[2] as u32 } else { 1 };
    let s = array.as_slice().to_vec();
    Some(if ch == 3 {
        let img = ImageBuffer::<Rgb<u8>, _>::from_raw(w, h, s)?;
        imageproc::map::map_pixels(&img, |p| image::Luma([((p.0[0] as u32 + p.0[1] as u32 + p.0[2] as u32) / 3) as u8]))
    } else if ch == 4 {
        let img = ImageBuffer::<Rgba<u8>, _>::from_raw(w, h, s)?;
        imageproc::map::map_pixels(&img, |p| image::Luma([((p.0[0] as u32 + p.0[1] as u32 + p.0[2] as u32) / 3) as u8]))
    } else {
        ImageBuffer::<image::Luma<u8>, _>::from_raw(w, h, s)?
    })
}

/// Returns the version string of the rust_vision crate.
#[export]
pub fn vision_get_version() -> String {
    "0.1.0".to_string()
}

/// Detects corners using the FAST-9 algorithm.
///
/// # Arguments
/// * `array` - Input image as a NumericArray.
/// * `threshold` - Intensity threshold for pixel differences.
///
/// # Returns
/// A NumericArray of shape [N, 2] containing {x, y} coordinates of detected corners.
#[export]
pub fn corners_fast9_memory(array: &NumericArray<u8>, threshold: i64) -> NumericArray<i64> {
    match to_luma(array) {
        Some(luma) => {
            let corners = imageproc::corners::corners_fast9(&luma, threshold as u8);
            let mut res = Vec::with_capacity(corners.len() * 2);
            for c in corners {
                res.push(c.x as i64);
                res.push(c.y as i64);
            }
            NumericArray::<i64>::from_array(&[res.len() / 2, 2], &res)
        },
        None => NumericArray::<i64>::from_slice(&[])
    }
}

/// Performs template matching between an image and a template.
///
/// # Arguments
/// * `array` - The source image to search in.
/// * `template_array` - The template image to search for.
/// * `method` - Matching method: 1 (SumOfSquaredErrors), 2 (SumOfSquaredErrorsNormalized),
///              3 (CrossCorrelation), 4 (CrossCorrelationNormalized).
///
/// # Returns
/// A 2D NumericArray (F64) representing the matching scores across the image.
#[export]
pub fn match_template_memory(array: &NumericArray<u8>, template_array: &NumericArray<u8>, method: i64) -> NumericArray<f64> {
    let luma1 = to_luma(array);
    let luma2 = to_luma(template_array);
    if let (Some(img), Some(tmpl)) = (luma1, luma2) {
        if tmpl.width() > img.width() || tmpl.height() > img.height() {
            return NumericArray::<f64>::from_slice(&[]);
        }
        let m = match method {
            1 => imageproc::template_matching::MatchTemplateMethod::SumOfSquaredErrors,
            2 => imageproc::template_matching::MatchTemplateMethod::SumOfSquaredErrorsNormalized,
            3 => imageproc::template_matching::MatchTemplateMethod::CrossCorrelation,
            4 => imageproc::template_matching::MatchTemplateMethod::CrossCorrelationNormalized,
            _ => imageproc::template_matching::MatchTemplateMethod::CrossCorrelationNormalized,
        };
        let res = imageproc::template_matching::match_template(&img, &tmpl, m);
        let h = res.height() as usize;
        let w = res.width() as usize;
        let mut f_res = Vec::with_capacity(h * w);
        for p in res.pixels() {
            f_res.push(p[0] as f64);
        }
        NumericArray::<f64>::from_array(&[h, w], &f_res)
    } else {
        NumericArray::<f64>::from_slice(&[])
    }
}

/// Computes the distance transform of a binary image.
///
/// # Arguments
/// * `array` - Input binary image.
/// * `norm` - Distance norm: 1 (L1/Manhattan), otherwise (L-Infinity/Chebyshev).
///
/// # Returns
/// A 2D NumericArray (U8) where each pixel value is the distance to the nearest background pixel.
#[export]
pub fn distance_transform_memory(array: &NumericArray<u8>, norm: i64) -> NumericArray<u8> {
    match to_luma(array) {
        Some(luma) => {
            let n = match norm {
                1 => imageproc::distance_transform::Norm::L1,
                _ => imageproc::distance_transform::Norm::LInf,
            };
            let res = imageproc::distance_transform::distance_transform(&luma, n);
            let dims = array.dimensions();
            let h = dims[0] as usize;
            let w = dims[1] as usize;
            NumericArray::<u8>::from_array(&[h, w, 1], &res.into_raw())
        },
        None => NumericArray::<u8>::from_slice(&[])
    }
}

/// Computes Sobel gradients (magnitude) of an image.
#[export]
pub fn sobel_gradients_memory(array: &NumericArray<u8>) -> NumericArray<u16> {
    match to_luma(array) {
        Some(luma) => {
            let res = imageproc::gradients::sobel_gradients(&luma);
            let h = res.height() as usize;
            let w = res.width() as usize;
            NumericArray::<u16>::from_array(&[h, w, 1], &res.into_raw())
        },
        None => NumericArray::<u16>::from_slice(&[])
    }
}

/// Computes Prewitt gradients (magnitude) of an image.
#[export]
pub fn prewitt_gradients_memory(array: &NumericArray<u8>) -> NumericArray<u16> {
    match to_luma(array) {
        Some(luma) => {
            let res = imageproc::gradients::prewitt_gradients(&luma);
            let h = res.height() as usize;
            let w = res.width() as usize;
            NumericArray::<u16>::from_array(&[h, w, 1], &res.into_raw())
        },
        None => NumericArray::<u16>::from_slice(&[])
    }
}

#[export]
pub fn horizontal_sobel_memory(array: &NumericArray<u8>) -> NumericArray<i16> {
    match to_luma(array) {
        Some(luma) => {
            let res = imageproc::gradients::horizontal_sobel(&luma);
            let h = res.height() as usize;
            let w = res.width() as usize;
            NumericArray::<i16>::from_array(&[h, w, 1], &res.into_raw())
        },
        None => NumericArray::<i16>::from_slice(&[])
    }
}

#[export]
pub fn vertical_sobel_memory(array: &NumericArray<u8>) -> NumericArray<i16> {
    match to_luma(array) {
        Some(luma) => {
            let res = imageproc::gradients::vertical_sobel(&luma);
            let h = res.height() as usize;
            let w = res.width() as usize;
            NumericArray::<i16>::from_array(&[h, w, 1], &res.into_raw())
        },
        None => NumericArray::<i16>::from_slice(&[])
    }
}

#[export]
pub fn horizontal_prewitt_memory(array: &NumericArray<u8>) -> NumericArray<i16> {
    match to_luma(array) {
        Some(luma) => {
            let res = imageproc::gradients::horizontal_prewitt(&luma);
            let h = res.height() as usize;
            let w = res.width() as usize;
            NumericArray::<i16>::from_array(&[h, w, 1], &res.into_raw())
        },
        None => NumericArray::<i16>::from_slice(&[])
    }
}

#[export]
pub fn vertical_prewitt_memory(array: &NumericArray<u8>) -> NumericArray<i16> {
    match to_luma(array) {
        Some(luma) => {
            let res = imageproc::gradients::vertical_prewitt(&luma);
            let h = res.height() as usize;
            let w = res.width() as usize;
            NumericArray::<i16>::from_array(&[h, w, 1], &res.into_raw())
        },
        None => NumericArray::<i16>::from_slice(&[])
    }
}

/// Computes the horizontal Scharr operator for an image.
#[export]
pub fn horizontal_scharr_memory(array: &NumericArray<u8>) -> NumericArray<i16> {
    match to_luma(array) {
        Some(luma) => {
            let res = imageproc::gradients::horizontal_scharr(&luma);
            let h = res.height() as usize;
            let w = res.width() as usize;
            NumericArray::<i16>::from_array(&[h, w, 1], &res.into_raw())
        },
        None => NumericArray::<i16>::from_slice(&[])
    }
}

/// Computes the vertical Scharr operator for an image.
#[export]
pub fn vertical_scharr_memory(array: &NumericArray<u8>) -> NumericArray<i16> {
    match to_luma(array) {
        Some(luma) => {
            let res = imageproc::gradients::vertical_scharr(&luma);
            let h = res.height() as usize;
            let w = res.width() as usize;
            NumericArray::<i16>::from_array(&[h, w, 1], &res.into_raw())
        },
        None => NumericArray::<i16>::from_slice(&[])
    }
}

/// Detects corners using the FAST-12 algorithm.
#[export]
pub fn corners_fast12_memory(array: &NumericArray<u8>, threshold: i64) -> NumericArray<i64> {
    match to_luma(array) {
        Some(luma) => {
            let corners = imageproc::corners::corners_fast12(&luma, threshold as u8);
            let mut res = Vec::with_capacity(corners.len() * 2);
            for c in corners {
                res.push(c.x as i64);
                res.push(c.y as i64);
            }
            NumericArray::<i64>::from_array(&[res.len() / 2, 2], &res)
        },
        None => NumericArray::<i64>::from_slice(&[])
    }
}

/// Performs connected components labeling on a binary image.
#[export]
pub fn connected_components_memory(array: &NumericArray<u8>, connectivity: i64) -> NumericArray<u32> {
    match to_luma(array) {
        Some(luma) => {
            let conn = if connectivity == 4 {
                imageproc::region_labelling::Connectivity::Four
            } else {
                imageproc::region_labelling::Connectivity::Eight
            };
            let res = imageproc::region_labelling::connected_components(&luma, conn, image::Luma([0u8]));
            let h = res.height() as usize;
            let w = res.width() as usize;
            NumericArray::<u32>::from_array(&[h, w, 1], &res.into_raw())
        },
        None => NumericArray::<u32>::from_slice(&[])
    }
}

/// Computes the Histogram of Oriented Gradients (HOG) descriptor.
///
/// # Arguments
/// * `array` - Input image.
/// * `orientations` - Number of orientation bins.
/// * `signed` - Whether to use signed or unsigned gradients.
/// * `cell_side` - Side length of a square cell in pixels.
/// * `block_side` - Side length of a square block in cells.
/// * `block_stride` - Stride between blocks in cells.
///
/// # Returns
/// A 1D NumericArray (F32) containing the full HOG descriptor vector.
#[export]
pub fn hog_memory(array: &NumericArray<u8>, orientations: i64, signed: bool, cell_side: i64, block_side: i64, block_stride: i64) -> NumericArray<f32> {
    match to_luma(array) {
        Some(luma) => {
            let options = imageproc::hog::HogOptions::new(
                orientations as usize,
                signed,
                cell_side as usize,
                block_side as usize,
                block_stride as usize,
            );
            if let Ok(desc) = imageproc::hog::hog(&luma, options) {
                NumericArray::<f32>::from_array(&[desc.len()], &desc)
            } else {
                NumericArray::<f32>::from_slice(&[])
            }
        },
        None => NumericArray::<f32>::from_slice(&[])
    }
}

/// Evaluates all Haar features for a given frame size on an image.
#[export]
pub fn evaluate_haar_features_memory(array: &NumericArray<u8>, frame_width: i64, frame_height: i64) -> NumericArray<i32> {
    match to_luma(array) {
        Some(luma) => {
            if luma.width() < frame_width as u32 || luma.height() < frame_height as u32 {
                 return NumericArray::<i32>::from_slice(&[]);
            }
            let integral = imageproc::integral_image::integral_image(&luma);
            let features = imageproc::haar::enumerate_haar_features(frame_width as u8, frame_height as u8);
            let mut results = Vec::with_capacity(features.len());
            for f in features {
                results.push(f.evaluate(&integral));
            }
            NumericArray::<i32>::from_array(&[results.len()], &results)
        },
        None => NumericArray::<i32>::from_slice(&[])
    }
}

/// Computes the Local Binary Pattern (LBP) image.
#[export]
pub fn local_binary_pattern_image_memory(array: &NumericArray<u8>) -> NumericArray<u8> {
    match to_luma(array) {
        Some(luma) => {
            let (width, height) = luma.dimensions();
            let mut out = image::ImageBuffer::new(width, height);
            for y in 1..height.saturating_sub(1) {
                for x in 1..width.saturating_sub(1) {
                    if let Some(p) = imageproc::local_binary_patterns::local_binary_pattern(&luma, x, y) {
                        out.put_pixel(x, y, image::Luma([p]));
                    }
                }
            }
            NumericArray::<u8>::from_array(&[height as usize, width as usize, 1], &out.into_raw())
        },
        None => NumericArray::<u8>::from_slice(&[])
    }
}

/// Performs non-maximum suppression on an image.
#[export]
pub fn suppress_non_maximum_memory(array: &NumericArray<u8>, radius: i64) -> NumericArray<u8> {
    match to_luma(array) {
        Some(luma) => {
            let res = imageproc::suppress::suppress_non_maximum(&luma, radius as u32);
            NumericArray::<u8>::from_array(&[luma.height() as usize, luma.width() as usize, 1], &res.into_raw())
        },
        None => NumericArray::<u8>::from_slice(&[])
    }
}
