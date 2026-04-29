use wolfram_library_link::export;
use image::imageops::FilterType;
use ab_glyph::{Font, FontRef, PxScale};

#[export]
fn get_version() -> String {
    "0.1.0".to_string()
}

#[export]
fn resize_image(input: String, output: String, width: i64, height: i64, filter_name: String) -> String {
    let img = match image::open(&input) {
        Ok(img) => img,
        Err(e) => return format!("Error opening input: {}", e),
    };

    let filter = match filter_name.as_str() {
        "Nearest" => FilterType::Nearest,
        "Triangle" => FilterType::Triangle,
        "CatmullRom" => FilterType::CatmullRom,
        "Gaussian" => FilterType::Gaussian,
        "Lanczos3" => FilterType::Lanczos3,
        _ => return format!("Error: Unknown filter type '{}'", filter_name),
    };

    // Resize exactly to the requested dimensions
    let resized = img.resize_exact(width as u32, height as u32, filter);

    match resized.save(&output) {
        Ok(_) => "Success".to_string(),
        Err(e) => format!("Error saving output: {}", e),
    }
}
#[export]
fn flip_image(input: String, output: String, direction: String) -> String {
    let img = match image::open(&input) {
        Ok(img) => img,
        Err(e) => return format!("Error opening input: {}", e),
    };

    let flipped = match direction.as_str() {
        "Horizontal" => img.fliph(),
        "Vertical" => img.flipv(),
        _ => return format!("Error: Unknown flip direction '{}'", direction),
    };

    match flipped.save(&output) {
        Ok(_) => "Success".to_string(),
        Err(e) => format!("Error saving output: {}", e),
    }
}

#[export]
fn rotate_image(input: String, output: String, angle: i64) -> String {
    let img = match image::open(&input) {
        Ok(img) => img,
        Err(e) => return format!("Error opening input: {}", e),
    };

    let rotated = match angle {
        90 => img.rotate90(),
        180 => img.rotate180(),
        270 => img.rotate270(),
        _ => return format!("Error: Unsupported rotation angle {}", angle),
    };

    match rotated.save(&output) {
        Ok(_) => "Success".to_string(),
        Err(e) => format!("Error saving output: {}", e),
    }
}

#[export]
fn crop_image(input: String, output: String, x: i64, y: i64, w: i64, h: i64) -> String {
    let mut img = match image::open(&input) {
        Ok(img) => img,
        Err(e) => return format!("Error opening input: {}", e),
    };

    let cropped = img.crop(x as u32, y as u32, w as u32, h as u32);

    match cropped.save(&output) {
        Ok(_) => "Success".to_string(),
        Err(e) => format!("Error saving output: {}", e),
    }
}
#[export]
fn grayscale_image(input: String, output: String) -> String {
    let img = match image::open(&input) {
        Ok(img) => img,
        Err(e) => return format!("Error opening input: {}", e),
    };

    let grayscaled = img.grayscale();

    match grayscaled.save(&output) {
        Ok(_) => "Success".to_string(),
        Err(e) => format!("Error saving output: {}", e),
    }
}

#[export]
fn invert_image(input: String, output: String) -> String {
    let mut img = match image::open(&input) {
        Ok(img) => img,
        Err(e) => return format!("Error opening input: {}", e),
    };

    img.invert();

    match img.save(&output) {
        Ok(_) => "Success".to_string(),
        Err(e) => format!("Error saving output: {}", e),
    }
}
#[export]
fn blur_image(input: String, output: String, sigma: f64) -> String {
    let img = match image::open(&input) {
        Ok(img) => img,
        Err(e) => return format!("Error opening input: {}", e),
    };

    let blurred = img.blur(sigma as f32);

    match blurred.save(&output) {
        Ok(_) => "Success".to_string(),
        Err(e) => format!("Error saving output: {}", e),
    }
}

#[export]
fn unsharpen_image(input: String, output: String, sigma: f64, threshold: i64) -> String {
    let img = match image::open(&input) {
        Ok(img) => img,
        Err(e) => return format!("Error opening input: {}", e),
    };

    let unsharpened = img.unsharpen(sigma as f32, threshold as i32);

    match unsharpened.save(&output) {
        Ok(_) => "Success".to_string(),
        Err(e) => format!("Error saving output: {}", e),
    }
}
#[export]
fn image_dimensions(input: String) -> String {
    match image::open(&input) {
        Ok(img) => format!("{},{}", img.width(), img.height()),
        Err(e) => format!("Error: {}", e),
    }
}

#[export]
fn image_color_type(input: String) -> String {
    match image::open(&input) {
        Ok(img) => format!("{:?}", img.color()),
        Err(e) => format!("Error: {}", e),
    }
}

use wolfram_library_link::NumericArray;
use image::{ImageBuffer, Rgb, Rgba};

#[export]
fn blur_memory(array: &NumericArray<u8>, sigma: f64) -> NumericArray<u8> {
    let dims = array.dimensions();
    if dims.len() < 3 {
        return NumericArray::<u8>::from_slice(array.as_slice());
    }
    
    let h = dims[0] as u32;
    let w = dims[1] as u32;
    let channels = dims[2] as u32;
    let slice = array.as_slice();

    if channels == 3 {
        let img = ImageBuffer::<Rgb<u8>, _>::from_raw(w, h, slice.to_vec()).unwrap();
        let blurred = image::imageops::blur(&img, sigma as f32);
        NumericArray::<u8>::from_slice(blurred.as_raw())
    } else if channels == 4 {
        let img = ImageBuffer::<Rgba<u8>, _>::from_raw(w, h, slice.to_vec()).unwrap();
        let blurred = image::imageops::blur(&img, sigma as f32);
        NumericArray::<u8>::from_slice(blurred.as_raw())
    } else {
        NumericArray::<u8>::from_slice(slice)
    }
}

#[export]
fn invert_memory(array: &NumericArray<u8>) -> NumericArray<u8> {
    let dims = array.dimensions();
    if dims.len() < 3 {
        return NumericArray::<u8>::from_slice(array.as_slice());
    }
    
    let h = dims[0] as u32;
    let w = dims[1] as u32;
    let channels = dims[2] as u32;
    let slice = array.as_slice();

    if channels == 3 {
        let mut img = ImageBuffer::<Rgb<u8>, _>::from_raw(w, h, slice.to_vec()).unwrap();
        image::imageops::invert(&mut img);
        NumericArray::<u8>::from_slice(img.as_raw())
    } else if channels == 4 {
        let mut img = ImageBuffer::<Rgba<u8>, _>::from_raw(w, h, slice.to_vec()).unwrap();
        image::imageops::invert(&mut img);
        NumericArray::<u8>::from_slice(img.as_raw())
    } else {
        NumericArray::<u8>::from_slice(slice)
    }
}

#[export]
fn unsharpen_memory(array: &NumericArray<u8>, sigma: f64, threshold: i64) -> NumericArray<u8> {
    let dims = array.dimensions();
    if dims.len() < 3 {
        return NumericArray::<u8>::from_slice(array.as_slice());
    }
    
    let h = dims[0] as u32;
    let w = dims[1] as u32;
    let channels = dims[2] as u32;
    let slice = array.as_slice();

    if channels == 3 {
        let img = ImageBuffer::<Rgb<u8>, _>::from_raw(w, h, slice.to_vec()).unwrap();
        let unsharpened = image::imageops::unsharpen(&img, sigma as f32, threshold as i32);
        NumericArray::<u8>::from_slice(unsharpened.as_raw())
    } else if channels == 4 {
        let img = ImageBuffer::<Rgba<u8>, _>::from_raw(w, h, slice.to_vec()).unwrap();
        let unsharpened = image::imageops::unsharpen(&img, sigma as f32, threshold as i32);
        NumericArray::<u8>::from_slice(unsharpened.as_raw())
    } else {
        NumericArray::<u8>::from_slice(slice)
    }
}

#[export]
fn flip_memory(array: &NumericArray<u8>, direction: String) -> NumericArray<u8> {
    let dims = array.dimensions();
    if dims.len() < 3 {
        return NumericArray::<u8>::from_slice(array.as_slice());
    }
    
    let h = dims[0] as u32;
    let w = dims[1] as u32;
    let channels = dims[2] as u32;
    let slice = array.as_slice();

    if channels == 3 {
        let img = ImageBuffer::<Rgb<u8>, _>::from_raw(w, h, slice.to_vec()).unwrap();
        let flipped = match direction.as_str() {
            "Horizontal" => image::imageops::flip_horizontal(&img),
            "Vertical" => image::imageops::flip_vertical(&img),
            _ => img,
        };
        NumericArray::<u8>::from_slice(flipped.as_raw())
    } else if channels == 4 {
        let img = ImageBuffer::<Rgba<u8>, _>::from_raw(w, h, slice.to_vec()).unwrap();
        let flipped = match direction.as_str() {
            "Horizontal" => image::imageops::flip_horizontal(&img),
            "Vertical" => image::imageops::flip_vertical(&img),
            _ => img,
        };
        NumericArray::<u8>::from_slice(flipped.as_raw())
    } else {
        NumericArray::<u8>::from_slice(slice)
    }
}
#[export]
fn rotate_memory(array: &NumericArray<u8>, angle: i64) -> NumericArray<u8> {
    let dims = array.dimensions();
    if dims.len() < 3 {
        return NumericArray::<u8>::from_slice(array.as_slice());
    }
    
    let h = dims[0] as u32;
    let w = dims[1] as u32;
    let channels = dims[2] as u32;
    let slice = array.as_slice();

    if channels == 3 {
        let img = ImageBuffer::<Rgb<u8>, _>::from_raw(w, h, slice.to_vec()).unwrap();
        let rotated = match angle {
            90 => image::imageops::rotate90(&img).as_raw().clone(),
            180 => image::imageops::rotate180(&img).as_raw().clone(),
            270 => image::imageops::rotate270(&img).as_raw().clone(),
            _ => img.as_raw().clone(),
        };
        NumericArray::<u8>::from_slice(&rotated)
    } else if channels == 4 {
        let img = ImageBuffer::<Rgba<u8>, _>::from_raw(w, h, slice.to_vec()).unwrap();
        let rotated = match angle {
            90 => image::imageops::rotate90(&img).as_raw().clone(),
            180 => image::imageops::rotate180(&img).as_raw().clone(),
            270 => image::imageops::rotate270(&img).as_raw().clone(),
            _ => img.as_raw().clone(),
        };
        NumericArray::<u8>::from_slice(&rotated)
    } else {
        NumericArray::<u8>::from_slice(slice)
    }
}

#[export]
fn grayscale_memory(array: &NumericArray<u8>) -> NumericArray<u8> {
    let dims = array.dimensions();
    if dims.len() < 3 {
        return NumericArray::<u8>::from_slice(array.as_slice());
    }
    
    let h = dims[0] as u32;
    let w = dims[1] as u32;
    let channels = dims[2] as u32;
    let slice = array.as_slice();

    if channels == 3 {
        let img = ImageBuffer::<Rgb<u8>, _>::from_raw(w, h, slice.to_vec()).unwrap();
        let grayscaled = image::imageops::grayscale(&img);
        NumericArray::<u8>::from_slice(grayscaled.as_raw())
    } else if channels == 4 {
        let img = ImageBuffer::<Rgba<u8>, _>::from_raw(w, h, slice.to_vec()).unwrap();
        let grayscaled = image::imageops::grayscale(&img);
        NumericArray::<u8>::from_slice(grayscaled.as_raw())
    } else {
        NumericArray::<u8>::from_slice(slice)
    }
}
#[export]
fn crop_memory(array: &NumericArray<u8>, x: i64, y: i64, target_w: i64, target_h: i64) -> NumericArray<u8> {
    let dims = array.dimensions();
    if dims.len() < 3 {
        return NumericArray::<u8>::from_slice(array.as_slice());
    }
    
    let h = dims[0] as u32;
    let w = dims[1] as u32;
    let channels = dims[2] as u32;
    let slice = array.as_slice();

    if channels == 3 {
        let mut img = ImageBuffer::<Rgb<u8>, _>::from_raw(w, h, slice.to_vec()).unwrap();
        let cropped = image::imageops::crop(&mut img, x as u32, y as u32, target_w as u32, target_h as u32).to_image();
        NumericArray::<u8>::from_slice(cropped.as_raw())
    } else if channels == 4 {
        let mut img = ImageBuffer::<Rgba<u8>, _>::from_raw(w, h, slice.to_vec()).unwrap();
        let cropped = image::imageops::crop(&mut img, x as u32, y as u32, target_w as u32, target_h as u32).to_image();
        NumericArray::<u8>::from_slice(cropped.as_raw())
    } else {
        NumericArray::<u8>::from_slice(slice)
    }
}

#[export]
fn resize_memory(array: &NumericArray<u8>, target_w: i64, target_h: i64, filter_name: String) -> NumericArray<u8> {
    let filter = match filter_name.as_str() {
        "Nearest" => FilterType::Nearest,
        "Triangle" => FilterType::Triangle,
        "CatmullRom" => FilterType::CatmullRom,
        "Gaussian" => FilterType::Gaussian,
        "Lanczos3" => FilterType::Lanczos3,
        _ => FilterType::Triangle,
    };

    let dims = array.dimensions();
    if dims.len() < 3 {
        return NumericArray::<u8>::from_slice(array.as_slice());
    }
    
    let h = dims[0] as u32;
    let w = dims[1] as u32;
    let channels = dims[2] as u32;
    let slice = array.as_slice();

    if channels == 3 {
        let img = ImageBuffer::<Rgb<u8>, _>::from_raw(w, h, slice.to_vec()).unwrap();
        let resized = image::imageops::resize(&img, target_w as u32, target_h as u32, filter);
        NumericArray::<u8>::from_slice(resized.as_raw())
    } else if channels == 4 {
        let img = ImageBuffer::<Rgba<u8>, _>::from_raw(w, h, slice.to_vec()).unwrap();
        let resized = image::imageops::resize(&img, target_w as u32, target_h as u32, filter);
        NumericArray::<u8>::from_slice(resized.as_raw())
    } else {
        NumericArray::<u8>::from_slice(slice)
    }
}
#[export]
fn canny_memory(array: &NumericArray<u8>, low: f64, high: f64) -> NumericArray<u8> {
    let dims = array.dimensions();
    if dims.len() < 3 {
        return NumericArray::<u8>::from_slice(array.as_slice());
    }
    
    let h = dims[0] as u32;
    let w = dims[1] as u32;
    let channels = dims[2] as u32;
    let slice = array.as_slice();

    let gray_img = if channels == 3 {
        let img = ImageBuffer::<Rgb<u8>, _>::from_raw(w, h, slice.to_vec()).unwrap();
        image::imageops::grayscale(&img)
    } else if channels == 4 {
        let img = ImageBuffer::<Rgba<u8>, _>::from_raw(w, h, slice.to_vec()).unwrap();
        image::imageops::grayscale(&img)
    } else {
        return NumericArray::<u8>::from_slice(slice);
    };

    let edges = imageproc::edges::canny(&gray_img, low as f32, high as f32);
    NumericArray::<u8>::from_slice(edges.as_raw())
}
#[export]
fn dilate_memory(array: &NumericArray<u8>, radius: i64) -> NumericArray<u8> {
    let dims = array.dimensions();
    if dims.len() < 3 {
        return NumericArray::<u8>::from_slice(array.as_slice());
    }
    
    let h = dims[0] as u32;
    let w = dims[1] as u32;
    let channels = dims[2] as u32;
    let slice = array.as_slice();

    let mask = imageproc::morphology::Mask::square(radius as u8);

    if channels == 1 {
        let img = ImageBuffer::<image::Luma<u8>, _>::from_raw(w, h, slice.to_vec()).unwrap();
        let dilated = imageproc::morphology::grayscale_dilate(&img, &mask);
        return NumericArray::<u8>::from_slice(dilated.as_raw());
    }

    let mut out_slice = vec![0u8; (w * h * channels) as usize];
    
    for c in 0..channels {
        let mut channel = ImageBuffer::<image::Luma<u8>, _>::new(w, h);
        for y in 0..h {
            for x in 0..w {
                let idx = ((y * w + x) * channels + c) as usize;
                channel.put_pixel(x, y, image::Luma([slice[idx]]));
            }
        }
        
        let dilated_channel = imageproc::morphology::grayscale_dilate(&channel, &mask);
        
        for y in 0..h {
            for x in 0..w {
                let idx = ((y * w + x) * channels + c) as usize;
                out_slice[idx] = dilated_channel.get_pixel(x, y)[0];
            }
        }
    }
    
    NumericArray::<u8>::from_slice(&out_slice)
}

#[export]
fn erode_memory(array: &NumericArray<u8>, radius: i64) -> NumericArray<u8> {
    let dims = array.dimensions();
    if dims.len() < 3 {
        return NumericArray::<u8>::from_slice(array.as_slice());
    }
    
    let h = dims[0] as u32;
    let w = dims[1] as u32;
    let channels = dims[2] as u32;
    let slice = array.as_slice();

    let mask = imageproc::morphology::Mask::square(radius as u8);

    if channels == 1 {
        let img = ImageBuffer::<image::Luma<u8>, _>::from_raw(w, h, slice.to_vec()).unwrap();
        let eroded = imageproc::morphology::grayscale_erode(&img, &mask);
        return NumericArray::<u8>::from_slice(eroded.as_raw());
    }

    let mut out_slice = vec![0u8; (w * h * channels) as usize];
    
    for c in 0..channels {
        let mut channel = ImageBuffer::<image::Luma<u8>, _>::new(w, h);
        for y in 0..h {
            for x in 0..w {
                let idx = ((y * w + x) * channels + c) as usize;
                channel.put_pixel(x, y, image::Luma([slice[idx]]));
            }
        }
        
        let eroded_channel = imageproc::morphology::grayscale_erode(&channel, &mask);
        
        for y in 0..h {
            for x in 0..w {
                let idx = ((y * w + x) * channels + c) as usize;
                out_slice[idx] = eroded_channel.get_pixel(x, y)[0];
            }
        }
    }
    
    NumericArray::<u8>::from_slice(&out_slice)
}

#[export]
fn median_memory(array: &NumericArray<u8>, x_radius: i64, y_radius: i64) -> NumericArray<u8> {
    let dims = array.dimensions();
    if dims.len() < 3 {
        return NumericArray::<u8>::from_slice(array.as_slice());
    }
    
    let h = dims[0] as u32;
    let w = dims[1] as u32;
    let channels = dims[2] as u32;
    let slice = array.as_slice();

    if channels == 3 {
        let img = ImageBuffer::<Rgb<u8>, _>::from_raw(w, h, slice.to_vec()).unwrap();
        let filtered = imageproc::filter::median_filter(&img, x_radius as u32, y_radius as u32);
        NumericArray::<u8>::from_slice(filtered.as_raw())
    } else if channels == 4 {
        let img = ImageBuffer::<Rgba<u8>, _>::from_raw(w, h, slice.to_vec()).unwrap();
        let filtered = imageproc::filter::median_filter(&img, x_radius as u32, y_radius as u32);
        NumericArray::<u8>::from_slice(filtered.as_raw())
    } else {
        let img = ImageBuffer::<image::Luma<u8>, _>::from_raw(w, h, slice.to_vec()).unwrap();
        let filtered = imageproc::filter::median_filter(&img, x_radius as u32, y_radius as u32);
        NumericArray::<u8>::from_slice(filtered.as_raw())
    }
}

#[export]
fn filter3x3_memory(array: &NumericArray<u8>, kernel_array: &NumericArray<f64>) -> NumericArray<u8> {
    let dims = array.dimensions();
    if dims.len() < 3 {
        return NumericArray::<u8>::from_slice(array.as_slice());
    }
    
    let kernel_slice = kernel_array.as_slice();
    let mut kernel = [0.0f32; 9];
    for i in 0..9.min(kernel_slice.len()) {
        kernel[i] = kernel_slice[i] as f32;
    }

    let h = dims[0] as u32;
    let w = dims[1] as u32;
    let channels = dims[2] as u32;
    let slice = array.as_slice();

    if channels == 3 {
        let img = ImageBuffer::<Rgb<u8>, _>::from_raw(w, h, slice.to_vec()).unwrap();
        let filtered = image::imageops::filter3x3(&img, &kernel);
        NumericArray::<u8>::from_slice(filtered.as_raw())
    } else if channels == 4 {
        let img = ImageBuffer::<Rgba<u8>, _>::from_raw(w, h, slice.to_vec()).unwrap();
        let filtered = image::imageops::filter3x3(&img, &kernel);
        NumericArray::<u8>::from_slice(filtered.as_raw())
    } else {
        let img = ImageBuffer::<image::Luma<u8>, _>::from_raw(w, h, slice.to_vec()).unwrap();
        let filtered = image::imageops::filter3x3(&img, &kernel);
        NumericArray::<u8>::from_slice(filtered.as_raw())
    }
}

#[export]
fn equalize_memory(array: &NumericArray<u8>) -> NumericArray<u8> {
    let dims = array.dimensions();
    if dims.len() < 3 {
        return NumericArray::<u8>::from_slice(array.as_slice());
    }
    
    let h = dims[0] as u32;
    let w = dims[1] as u32;
    let channels = dims[2] as u32;
    let slice = array.as_slice();

    if channels == 1 {
        let img = ImageBuffer::<image::Luma<u8>, _>::from_raw(w, h, slice.to_vec()).unwrap();
        let eq = imageproc::contrast::equalize_histogram(&img);
        return NumericArray::<u8>::from_slice(eq.as_raw());
    }

    let mut out_slice = vec![0u8; (w * h * channels) as usize];
    
    for c in 0..channels {
        let mut channel = ImageBuffer::<image::Luma<u8>, _>::new(w, h);
        for y in 0..h {
            for x in 0..w {
                let idx = ((y * w + x) * channels + c) as usize;
                channel.put_pixel(x, y, image::Luma([slice[idx]]));
            }
        }
        
        let eq_channel = imageproc::contrast::equalize_histogram(&channel);
        
        for y in 0..h {
            for x in 0..w {
                let idx = ((y * w + x) * channels + c) as usize;
                out_slice[idx] = eq_channel.get_pixel(x, y)[0];
            }
        }
    }
    
    NumericArray::<u8>::from_slice(&out_slice)
}

#[export]
fn adaptive_threshold_memory(array: &NumericArray<u8>, block_radius: i64, delta: i64) -> NumericArray<u8> {
    let dims = array.dimensions();
    if dims.len() < 3 {
        return NumericArray::<u8>::from_slice(array.as_slice());
    }
    
    let h = dims[0] as u32;
    let w = dims[1] as u32;
    let channels = dims[2] as u32;
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

    let thresh = imageproc::contrast::adaptive_threshold(&gray_img, block_radius as u32, delta as i32);
    NumericArray::<u8>::from_slice(thresh.as_raw())
}

#[export]
fn draw_line_memory(array: &NumericArray<u8>, x1: f64, y1: f64, x2: f64, y2: f64, color_array: &NumericArray<u8>) -> NumericArray<u8> {
    let dims = array.dimensions();
    if dims.len() < 3 {
        return NumericArray::<u8>::from_slice(array.as_slice());
    }
    
    let h = dims[0] as u32;
    let w = dims[1] as u32;
    let channels = dims[2] as u32;
    let slice = array.as_slice();
    let color_slice = color_array.as_slice();

    if channels == 3 {
        let mut img = ImageBuffer::<Rgb<u8>, _>::from_raw(w, h, slice.to_vec()).unwrap();
        let c = if color_slice.len() >= 3 {
            Rgb([color_slice[0], color_slice[1], color_slice[2]])
        } else {
            Rgb([255, 255, 255])
        };
        imageproc::drawing::draw_line_segment_mut(&mut img, (x1 as f32, y1 as f32), (x2 as f32, y2 as f32), c);
        NumericArray::<u8>::from_slice(img.as_raw())
    } else if channels == 4 {
        let mut img = ImageBuffer::<Rgba<u8>, _>::from_raw(w, h, slice.to_vec()).unwrap();
        let c = if color_slice.len() >= 4 {
            Rgba([color_slice[0], color_slice[1], color_slice[2], color_slice[3]])
        } else if color_slice.len() >= 3 {
            Rgba([color_slice[0], color_slice[1], color_slice[2], 255])
        } else {
            Rgba([255, 255, 255, 255])
        };
        imageproc::drawing::draw_line_segment_mut(&mut img, (x1 as f32, y1 as f32), (x2 as f32, y2 as f32), c);
        NumericArray::<u8>::from_slice(img.as_raw())
    } else {
        let mut img = ImageBuffer::<image::Luma<u8>, _>::from_raw(w, h, slice.to_vec()).unwrap();
        let c = if !color_slice.is_empty() {
            image::Luma([color_slice[0]])
        } else {
            image::Luma([255])
        };
        imageproc::drawing::draw_line_segment_mut(&mut img, (x1 as f32, y1 as f32), (x2 as f32, y2 as f32), c);
        NumericArray::<u8>::from_slice(img.as_raw())
    }
}

#[export]
fn draw_rect_memory(array: &NumericArray<u8>, x: i64, y: i64, rect_w: i64, rect_h: i64, color_array: &NumericArray<u8>, filled: bool) -> NumericArray<u8> {
    let dims = array.dimensions();
    if dims.len() < 3 {
        return NumericArray::<u8>::from_slice(array.as_slice());
    }
    
    let h = dims[0] as u32;
    let w = dims[1] as u32;
    let channels = dims[2] as u32;
    let slice = array.as_slice();
    let color_slice = color_array.as_slice();
    let rect = imageproc::rect::Rect::at(x as i32, y as i32).of_size(rect_w as u32, rect_h as u32);

    if channels == 3 {
        let mut img = ImageBuffer::<Rgb<u8>, _>::from_raw(w, h, slice.to_vec()).unwrap();
        let c = if color_slice.len() >= 3 {
            Rgb([color_slice[0], color_slice[1], color_slice[2]])
        } else {
            Rgb([255, 255, 255])
        };
        if filled {
            imageproc::drawing::draw_filled_rect_mut(&mut img, rect, c);
        } else {
            imageproc::drawing::draw_hollow_rect_mut(&mut img, rect, c);
        }
        NumericArray::<u8>::from_slice(img.as_raw())
    } else if channels == 4 {
        let mut img = ImageBuffer::<Rgba<u8>, _>::from_raw(w, h, slice.to_vec()).unwrap();
        let c = if color_slice.len() >= 4 {
            Rgba([color_slice[0], color_slice[1], color_slice[2], color_slice[3]])
        } else if color_slice.len() >= 3 {
            Rgba([color_slice[0], color_slice[1], color_slice[2], 255])
        } else {
            Rgba([255, 255, 255, 255])
        };
        if filled {
            imageproc::drawing::draw_filled_rect_mut(&mut img, rect, c);
        } else {
            imageproc::drawing::draw_hollow_rect_mut(&mut img, rect, c);
        }
        NumericArray::<u8>::from_slice(img.as_raw())
    } else {
        let mut img = ImageBuffer::<image::Luma<u8>, _>::from_raw(w, h, slice.to_vec()).unwrap();
        let c = if !color_slice.is_empty() {
            image::Luma([color_slice[0]])
        } else {
            image::Luma([255])
        };
        if filled {
            imageproc::drawing::draw_filled_rect_mut(&mut img, rect, c);
        } else {
            imageproc::drawing::draw_hollow_rect_mut(&mut img, rect, c);
        }
        NumericArray::<u8>::from_slice(img.as_raw())
    }
}

#[export]
fn draw_circle_memory(array: &NumericArray<u8>, cx: i64, cy: i64, radius: i64, color_array: &NumericArray<u8>, filled: bool) -> NumericArray<u8> {
    let dims = array.dimensions();
    if dims.len() < 3 {
        return NumericArray::<u8>::from_slice(array.as_slice());
    }
    
    let h = dims[0] as u32;
    let w = dims[1] as u32;
    let channels = dims[2] as u32;
    let slice = array.as_slice();
    let color_slice = color_array.as_slice();

    if channels == 3 {
        let mut img = ImageBuffer::<Rgb<u8>, _>::from_raw(w, h, slice.to_vec()).unwrap();
        let c = if color_slice.len() >= 3 {
            Rgb([color_slice[0], color_slice[1], color_slice[2]])
        } else {
            Rgb([255, 255, 255])
        };
        if filled {
            imageproc::drawing::draw_filled_circle_mut(&mut img, (cx as i32, cy as i32), radius as i32, c);
        } else {
            imageproc::drawing::draw_hollow_circle_mut(&mut img, (cx as i32, cy as i32), radius as i32, c);
        }
        NumericArray::<u8>::from_slice(img.as_raw())
    } else if channels == 4 {
        let mut img = ImageBuffer::<Rgba<u8>, _>::from_raw(w, h, slice.to_vec()).unwrap();
        let c = if color_slice.len() >= 4 {
            Rgba([color_slice[0], color_slice[1], color_slice[2], color_slice[3]])
        } else if color_slice.len() >= 3 {
            Rgba([color_slice[0], color_slice[1], color_slice[2], 255])
        } else {
            Rgba([255, 255, 255, 255])
        };
        if filled {
            imageproc::drawing::draw_filled_circle_mut(&mut img, (cx as i32, cy as i32), radius as i32, c);
        } else {
            imageproc::drawing::draw_hollow_circle_mut(&mut img, (cx as i32, cy as i32), radius as i32, c);
        }
        NumericArray::<u8>::from_slice(img.as_raw())
    } else {
        let mut img = ImageBuffer::<image::Luma<u8>, _>::from_raw(w, h, slice.to_vec()).unwrap();
        let c = if !color_slice.is_empty() {
            image::Luma([color_slice[0]])
        } else {
            image::Luma([255])
        };
        if filled {
            imageproc::drawing::draw_filled_circle_mut(&mut img, (cx as i32, cy as i32), radius as i32, c);
        } else {
            imageproc::drawing::draw_hollow_circle_mut(&mut img, (cx as i32, cy as i32), radius as i32, c);
        }
        NumericArray::<u8>::from_slice(img.as_raw())
    }
}

#[export]
fn draw_ellipse_memory(array: &NumericArray<u8>, cx: i64, cy: i64, rx: i64, ry: i64, color_array: &NumericArray<u8>, filled: bool) -> NumericArray<u8> {
    let dims = array.dimensions();
    if dims.len() < 3 {
        return NumericArray::<u8>::from_slice(array.as_slice());
    }
    
    let h = dims[0] as u32;
    let w = dims[1] as u32;
    let channels = dims[2] as u32;
    let slice = array.as_slice();
    let color_slice = color_array.as_slice();

    if channels == 3 {
        let mut img = ImageBuffer::<Rgb<u8>, _>::from_raw(w, h, slice.to_vec()).unwrap();
        let c = if color_slice.len() >= 3 {
            Rgb([color_slice[0], color_slice[1], color_slice[2]])
        } else {
            Rgb([255, 255, 255])
        };
        if filled {
            imageproc::drawing::draw_filled_ellipse_mut(&mut img, (cx as i32, cy as i32), rx as i32, ry as i32, c);
        } else {
            imageproc::drawing::draw_hollow_ellipse_mut(&mut img, (cx as i32, cy as i32), rx as i32, ry as i32, c);
        }
        NumericArray::<u8>::from_slice(img.as_raw())
    } else if channels == 4 {
        let mut img = ImageBuffer::<Rgba<u8>, _>::from_raw(w, h, slice.to_vec()).unwrap();
        let c = if color_slice.len() >= 4 {
            Rgba([color_slice[0], color_slice[1], color_slice[2], color_slice[3]])
        } else if color_slice.len() >= 3 {
            Rgba([color_slice[0], color_slice[1], color_slice[2], 255])
        } else {
            Rgba([255, 255, 255, 255])
        };
        if filled {
            imageproc::drawing::draw_filled_ellipse_mut(&mut img, (cx as i32, cy as i32), rx as i32, ry as i32, c);
        } else {
            imageproc::drawing::draw_hollow_ellipse_mut(&mut img, (cx as i32, cy as i32), rx as i32, ry as i32, c);
        }
        NumericArray::<u8>::from_slice(img.as_raw())
    } else {
        let mut img = ImageBuffer::<image::Luma<u8>, _>::from_raw(w, h, slice.to_vec()).unwrap();
        let c = if !color_slice.is_empty() {
            image::Luma([color_slice[0]])
        } else {
            image::Luma([255])
        };
        if filled {
            imageproc::drawing::draw_filled_ellipse_mut(&mut img, (cx as i32, cy as i32), rx as i32, ry as i32, c);
        } else {
            imageproc::drawing::draw_hollow_ellipse_mut(&mut img, (cx as i32, cy as i32), rx as i32, ry as i32, c);
        }
        NumericArray::<u8>::from_slice(img.as_raw())
    }
}

#[export]
fn draw_polygon_memory(array: &NumericArray<u8>, points_x: &NumericArray<i64>, points_y: &NumericArray<i64>, color_array: &NumericArray<u8>, filled: bool) -> NumericArray<u8> {
    let dims = array.dimensions();
    if dims.len() < 3 {
        return NumericArray::<u8>::from_slice(array.as_slice());
    }
    
    let h = dims[0] as u32;
    let w = dims[1] as u32;
    let channels = dims[2] as u32;
    let slice = array.as_slice();
    let color_slice = color_array.as_slice();

    let px = points_x.as_slice();
    let py = points_y.as_slice();
    let mut poly_i32 = Vec::new();
    let mut poly_f32 = Vec::new();
    let len = std::cmp::min(px.len(), py.len());
    for i in 0..len {
        poly_i32.push(imageproc::point::Point::new(px[i] as i32, py[i] as i32));
        poly_f32.push(imageproc::point::Point::new(px[i] as f32, py[i] as f32));
    }

    if channels == 3 {
        let mut img = ImageBuffer::<Rgb<u8>, _>::from_raw(w, h, slice.to_vec()).unwrap();
        let c = if color_slice.len() >= 3 {
            Rgb([color_slice[0], color_slice[1], color_slice[2]])
        } else {
            Rgb([255, 255, 255])
        };
        if filled {
            imageproc::drawing::draw_polygon_mut(&mut img, &poly_i32, c);
        } else {
            imageproc::drawing::draw_hollow_polygon_mut(&mut img, &poly_f32, c);
        }
        NumericArray::<u8>::from_slice(img.as_raw())
    } else if channels == 4 {
        let mut img = ImageBuffer::<Rgba<u8>, _>::from_raw(w, h, slice.to_vec()).unwrap();
        let c = if color_slice.len() >= 4 {
            Rgba([color_slice[0], color_slice[1], color_slice[2], color_slice[3]])
        } else if color_slice.len() >= 3 {
            Rgba([color_slice[0], color_slice[1], color_slice[2], 255])
        } else {
            Rgba([255, 255, 255, 255])
        };
        if filled {
            imageproc::drawing::draw_polygon_mut(&mut img, &poly_i32, c);
        } else {
            imageproc::drawing::draw_hollow_polygon_mut(&mut img, &poly_f32, c);
        }
        NumericArray::<u8>::from_slice(img.as_raw())
    } else {
        let mut img = ImageBuffer::<image::Luma<u8>, _>::from_raw(w, h, slice.to_vec()).unwrap();
        let c = if !color_slice.is_empty() {
            image::Luma([color_slice[0]])
        } else {
            image::Luma([255])
        };
        if filled {
            imageproc::drawing::draw_polygon_mut(&mut img, &poly_i32, c);
        } else {
            imageproc::drawing::draw_hollow_polygon_mut(&mut img, &poly_f32, c);
        }
        NumericArray::<u8>::from_slice(img.as_raw())
    }
}

#[export]
fn shrink_width_memory(array: &NumericArray<u8>, target_width: i64) -> NumericArray<u8> {
    let dims = array.dimensions();
    if dims.len() < 3 {
        return NumericArray::<u8>::from_slice(array.as_slice());
    }
    
    let h = dims[0] as u32;
    let w = dims[1] as u32;
    let channels = dims[2] as u32;
    let slice = array.as_slice();

    if target_width as u32 >= w {
        return NumericArray::<u8>::from_slice(slice);
    }

    if channels == 3 {
        let img = ImageBuffer::<Rgb<u8>, _>::from_raw(w, h, slice.to_vec()).unwrap();
        let shrunk = imageproc::seam_carving::shrink_width(&img, target_width as u32);
        NumericArray::<u8>::from_slice(shrunk.as_raw())
    } else if channels == 4 {
        let img = ImageBuffer::<Rgba<u8>, _>::from_raw(w, h, slice.to_vec()).unwrap();
        let shrunk = imageproc::seam_carving::shrink_width(&img, target_width as u32);
        NumericArray::<u8>::from_slice(shrunk.as_raw())
    } else {
        let img = ImageBuffer::<image::Luma<u8>, _>::from_raw(w, h, slice.to_vec()).unwrap();
        let shrunk = imageproc::seam_carving::shrink_width(&img, target_width as u32);
        NumericArray::<u8>::from_slice(shrunk.as_raw())
    }
}

#[export]
fn flood_fill_memory(array: &NumericArray<u8>, x: i64, y: i64, color_array: &NumericArray<u8>) -> NumericArray<u8> {
    let dims = array.dimensions();
    if dims.len() < 3 { return NumericArray::<u8>::from_slice(array.as_slice()); }
    let (h, w, channels) = (dims[0] as u32, dims[1] as u32, dims[2] as u32);
    let slice = array.as_slice();
    let color_slice = color_array.as_slice();

    if channels == 3 {
        let mut img = ImageBuffer::<Rgb<u8>, _>::from_raw(w, h, slice.to_vec()).unwrap();
        let c = if color_slice.len() >= 3 { Rgb([color_slice[0], color_slice[1], color_slice[2]]) } else { Rgb([255, 255, 255]) };
        imageproc::drawing::flood_fill_mut(&mut img, x as u32, y as u32, c);
        NumericArray::<u8>::from_slice(img.as_raw())
    } else if channels == 4 {
        let mut img = ImageBuffer::<Rgba<u8>, _>::from_raw(w, h, slice.to_vec()).unwrap();
        let c = if color_slice.len() >= 4 { Rgba([color_slice[0], color_slice[1], color_slice[2], color_slice[3]]) } else if color_slice.len() >= 3 { Rgba([color_slice[0], color_slice[1], color_slice[2], 255]) } else { Rgba([255, 255, 255, 255]) };
        imageproc::drawing::flood_fill_mut(&mut img, x as u32, y as u32, c);
        NumericArray::<u8>::from_slice(img.as_raw())
    } else {
        let mut img = ImageBuffer::<image::Luma<u8>, _>::from_raw(w, h, slice.to_vec()).unwrap();
        let c = if !color_slice.is_empty() { image::Luma([color_slice[0]]) } else { image::Luma([255]) };
        imageproc::drawing::flood_fill_mut(&mut img, x as u32, y as u32, c);
        NumericArray::<u8>::from_slice(img.as_raw())
    }
}

#[export]
fn draw_antialiased_line_memory(array: &NumericArray<u8>, x1: i64, y1: i64, x2: i64, y2: i64, color_array: &NumericArray<u8>) -> NumericArray<u8> {
    let dims = array.dimensions();
    if dims.len() < 3 { return NumericArray::<u8>::from_slice(array.as_slice()); }
    let (h, w, channels) = (dims[0] as u32, dims[1] as u32, dims[2] as u32);
    let slice = array.as_slice();
    let color_slice = color_array.as_slice();

    if channels == 3 {
        let mut img = ImageBuffer::<Rgb<u8>, _>::from_raw(w, h, slice.to_vec()).unwrap();
        let c = if color_slice.len() >= 3 { Rgb([color_slice[0], color_slice[1], color_slice[2]]) } else { Rgb([255, 255, 255]) };
        imageproc::drawing::draw_antialiased_line_segment_mut(&mut img, (x1 as i32, y1 as i32), (x2 as i32, y2 as i32), c, |p1, p2, alpha| {
            imageproc::pixelops::interpolate(p1, p2, alpha)
        });
        NumericArray::<u8>::from_slice(img.as_raw())
    } else if channels == 4 {
        let mut img = ImageBuffer::<Rgba<u8>, _>::from_raw(w, h, slice.to_vec()).unwrap();
        let c = if color_slice.len() >= 4 { Rgba([color_slice[0], color_slice[1], color_slice[2], color_slice[3]]) } else if color_slice.len() >= 3 { Rgba([color_slice[0], color_slice[1], color_slice[2], 255]) } else { Rgba([255, 255, 255, 255]) };
        imageproc::drawing::draw_antialiased_line_segment_mut(&mut img, (x1 as i32, y1 as i32), (x2 as i32, y2 as i32), c, |p1, p2, alpha| {
            imageproc::pixelops::interpolate(p1, p2, alpha)
        });
        NumericArray::<u8>::from_slice(img.as_raw())
    } else {
        let mut img = ImageBuffer::<image::Luma<u8>, _>::from_raw(w, h, slice.to_vec()).unwrap();
        let c = if !color_slice.is_empty() { image::Luma([color_slice[0]]) } else { image::Luma([255]) };
        imageproc::drawing::draw_antialiased_line_segment_mut(&mut img, (x1 as i32, y1 as i32), (x2 as i32, y2 as i32), c, |p1, p2, alpha| {
            imageproc::pixelops::interpolate(p1, p2, alpha)
        });
        NumericArray::<u8>::from_slice(img.as_raw())
    }
}

#[export]
fn draw_bezier_memory(array: &NumericArray<u8>, x1: i64, y1: i64, x2: i64, y2: i64, x3: i64, y3: i64, x4: i64, y4: i64, color_array: &NumericArray<u8>) -> NumericArray<u8> {
    let dims = array.dimensions();
    if dims.len() < 3 { return NumericArray::<u8>::from_slice(array.as_slice()); }
    let (h, w, channels) = (dims[0] as u32, dims[1] as u32, dims[2] as u32);
    let slice = array.as_slice();
    let color_slice = color_array.as_slice();

    if channels == 3 {
        let mut img = ImageBuffer::<Rgb<u8>, _>::from_raw(w, h, slice.to_vec()).unwrap();
        let c = if color_slice.len() >= 3 { Rgb([color_slice[0], color_slice[1], color_slice[2]]) } else { Rgb([255, 255, 255]) };
        imageproc::drawing::draw_cubic_bezier_curve_mut(&mut img, (x1 as f32, y1 as f32), (x4 as f32, y4 as f32), (x2 as f32, y2 as f32), (x3 as f32, y3 as f32), c);
        NumericArray::<u8>::from_slice(img.as_raw())
    } else if channels == 4 {
        let mut img = ImageBuffer::<Rgba<u8>, _>::from_raw(w, h, slice.to_vec()).unwrap();
        let c = if color_slice.len() >= 4 { Rgba([color_slice[0], color_slice[1], color_slice[2], color_slice[3]]) } else if color_slice.len() >= 3 { Rgba([color_slice[0], color_slice[1], color_slice[2], 255]) } else { Rgba([255, 255, 255, 255]) };
        imageproc::drawing::draw_cubic_bezier_curve_mut(&mut img, (x1 as f32, y1 as f32), (x4 as f32, y4 as f32), (x2 as f32, y2 as f32), (x3 as f32, y3 as f32), c);
        NumericArray::<u8>::from_slice(img.as_raw())
    } else {
        let mut img = ImageBuffer::<image::Luma<u8>, _>::from_raw(w, h, slice.to_vec()).unwrap();
        let c = if !color_slice.is_empty() { image::Luma([color_slice[0]]) } else { image::Luma([255]) };
        imageproc::drawing::draw_cubic_bezier_curve_mut(&mut img, (x1 as f32, y1 as f32), (x4 as f32, y4 as f32), (x2 as f32, y2 as f32), (x3 as f32, y3 as f32), c);
        NumericArray::<u8>::from_slice(img.as_raw())
    }
}

#[export]
fn draw_text_memory(array: &NumericArray<u8>, x: i64, y: i64, scale: f64, font_path: String, text: String, color_array: &NumericArray<u8>) -> NumericArray<u8> {
    let dims = array.dimensions();
    if dims.len() < 3 { return NumericArray::<u8>::from_slice(array.as_slice()); }
    let (h, w, channels) = (dims[0] as u32, dims[1] as u32, dims[2] as u32);
    let slice = array.as_slice();
    let color_slice = color_array.as_slice();

    let font_data = match std::fs::read(&font_path) {
        Ok(data) => data,
        Err(_) => return NumericArray::<u8>::from_slice(slice),
    };
    let font = match FontRef::try_from_slice(&font_data) {
        Ok(f) => f,
        Err(_) => return NumericArray::<u8>::from_slice(slice),
    };

    let px_scale = PxScale::from(scale as f32);

    if channels == 3 {
        let mut img = ImageBuffer::<Rgb<u8>, _>::from_raw(w, h, slice.to_vec()).unwrap();
        let c = if color_slice.len() >= 3 { Rgb([color_slice[0], color_slice[1], color_slice[2]]) } else { Rgb([255, 255, 255]) };
        imageproc::drawing::draw_text_mut(&mut img, c, x as i32, y as i32, px_scale, &font, &text);
        NumericArray::<u8>::from_slice(img.as_raw())
    } else if channels == 4 {
        let mut img = ImageBuffer::<Rgba<u8>, _>::from_raw(w, h, slice.to_vec()).unwrap();
        let c = if color_slice.len() >= 4 { Rgba([color_slice[0], color_slice[1], color_slice[2], color_slice[3]]) } else if color_slice.len() >= 3 { Rgba([color_slice[0], color_slice[1], color_slice[2], 255]) } else { Rgba([255, 255, 255, 255]) };
        imageproc::drawing::draw_text_mut(&mut img, c, x as i32, y as i32, px_scale, &font, &text);
        NumericArray::<u8>::from_slice(img.as_raw())
    } else {
        let mut img = ImageBuffer::<image::Luma<u8>, _>::from_raw(w, h, slice.to_vec()).unwrap();
        let c = if !color_slice.is_empty() { image::Luma([color_slice[0]]) } else { image::Luma([255]) };
        imageproc::drawing::draw_text_mut(&mut img, c, x as i32, y as i32, px_scale, &font, &text);
        NumericArray::<u8>::from_slice(img.as_raw())
    }
}
