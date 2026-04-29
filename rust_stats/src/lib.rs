use wolfram_library_link::{export, NumericArray};
use image::{ImageBuffer, Rgb, Rgba};

fn to_luma(array: &NumericArray<u8>) -> Option<ImageBuffer<image::Luma<u8>, Vec<u8>>> {
    let dims = array.dimensions();
    if dims.len() < 3 { return None; }
    let (h, w, ch) = (dims[0] as u32, dims[1] as u32, dims[2] as u32);
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

#[export]
fn stats_get_version() -> String {
    "0.1.0".to_string()
}

/// Returns a flat array of shape [channels × 256] (row-major) with per-channel histograms.
#[export]
fn histogram_memory(array: &NumericArray<u8>) -> NumericArray<u32> {
    let dims = array.dimensions();
    if dims.len() < 3 { return NumericArray::<u32>::from_slice(&[0u32; 256]); }
    let (h, w, channels) = (dims[0] as u32, dims[1] as u32, dims[2] as u32);
    let slice = array.as_slice();
    let mut result: Vec<u32> = Vec::with_capacity((channels as usize) * 256);
    if channels == 3 {
        let img = ImageBuffer::<Rgb<u8>, _>::from_raw(w, h, slice.to_vec()).unwrap();
        for i in 0..3usize {
            let ch = imageproc::map::map_pixels(&img, |p| image::Luma([p.0[i]]));
            result.extend_from_slice(&imageproc::stats::histogram(&ch).channels[0]);
        }
    } else if channels == 4 {
        let img = ImageBuffer::<Rgba<u8>, _>::from_raw(w, h, slice.to_vec()).unwrap();
        for i in 0..4usize {
            let ch = imageproc::map::map_pixels(&img, |p| image::Luma([p.0[i]]));
            result.extend_from_slice(&imageproc::stats::histogram(&ch).channels[0]);
        }
    } else {
        let img = ImageBuffer::<image::Luma<u8>, _>::from_raw(w, h, slice.to_vec()).unwrap();
        result.extend_from_slice(&imageproc::stats::histogram(&img).channels[0]);
    }
    NumericArray::<u32>::from_slice(&result)
}

/// Peak Signal-to-Noise Ratio between two same-size images.
#[export]
fn psnr_memory(array1: &NumericArray<u8>, array2: &NumericArray<u8>) -> f64 {
    let d1 = array1.dimensions();
    let d2 = array2.dimensions();
    if d1 != d2 || d1.len() < 3 { return 0.0; }
    let (h, w, ch) = (d1[0] as u32, d1[1] as u32, d1[2] as u32);
    if ch == 3 {
        let i1 = ImageBuffer::<Rgb<u8>, _>::from_raw(w, h, array1.as_slice().to_vec()).unwrap();
        let i2 = ImageBuffer::<Rgb<u8>, _>::from_raw(w, h, array2.as_slice().to_vec()).unwrap();
        imageproc::stats::peak_signal_to_noise_ratio(&i1, &i2)
    } else if ch == 4 {
        let i1 = ImageBuffer::<Rgba<u8>, _>::from_raw(w, h, array1.as_slice().to_vec()).unwrap();
        let i2 = ImageBuffer::<Rgba<u8>, _>::from_raw(w, h, array2.as_slice().to_vec()).unwrap();
        imageproc::stats::peak_signal_to_noise_ratio(&i1, &i2)
    } else {
        let i1 = ImageBuffer::<image::Luma<u8>, _>::from_raw(w, h, array1.as_slice().to_vec()).unwrap();
        let i2 = ImageBuffer::<image::Luma<u8>, _>::from_raw(w, h, array2.as_slice().to_vec()).unwrap();
        imageproc::stats::peak_signal_to_noise_ratio(&i1, &i2)
    }
}

/// 64-bit perceptual average-hash: resize to 8×8, compare each pixel to mean.
#[export]
fn phash_memory(array: &NumericArray<u8>) -> i64 {
    let luma = match to_luma(array) { Some(l) => l, None => return 0 };
    let small = image::imageops::resize(&luma, 8, 8, image::imageops::FilterType::Lanczos3);
    let pixels: Vec<u32> = small.pixels().map(|p| p.0[0] as u32).collect();
    if pixels.len() < 64 { return 0; }
    let mean = pixels.iter().sum::<u32>() / 64;
    pixels.iter().take(64).enumerate().fold(0u64, |acc, (i, &v)| {
        if v > mean { acc | (1u64 << i) } else { acc }
    }) as i64
}

/// Otsu's optimal binarisation threshold (0-255) on the luminance channel.
#[export]
fn otsu_level_memory(array: &NumericArray<u8>) -> i64 {
    match to_luma(array) {
        Some(luma) => imageproc::contrast::otsu_level(&luma) as i64,
        None => 0,
    }
}
