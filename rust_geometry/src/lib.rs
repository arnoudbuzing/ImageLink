use wolfram_library_link::{export, NumericArray};
use image::{ImageBuffer, Rgb, Rgba, Luma};
use imageproc::morphology;

#[export]
fn get_geometry_version() -> String {
    "0.1.0".to_string()
}

#[export]
fn hough_lines_memory(array: &NumericArray<u8>, vote_threshold: i64, suppression_radius: i64) -> NumericArray<f64> {
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

#[export]
fn morphology_open_memory(array: &NumericArray<u8>, norm: i64, k: i64) -> NumericArray<u8> {
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

#[export]
fn morphology_close_memory(array: &NumericArray<u8>, norm: i64, k: i64) -> NumericArray<u8> {
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

#[export]
fn geometry_rotate_about_center_memory(array: &NumericArray<u8>, theta: f64, interpolation: i64) -> NumericArray<u8> {
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

#[export]
fn geometry_affine_memory(array: &NumericArray<u8>, matrix: &NumericArray<f64>, interpolation: i64) -> NumericArray<u8> {
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
