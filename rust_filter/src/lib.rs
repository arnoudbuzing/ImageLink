use wolfram_library_link::{export, NumericArray};
use image::{ImageBuffer, Rgb, Rgba};
use imageproc::filter::bilateral::GaussianEuclideanColorDistance;

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

#[export]
fn filter_bilateral_memory(array: &NumericArray<u8>, radius: i64, sigma_spatial: f64, sigma_color: f64) -> NumericArray<u8> {
    match to_luma(array) {
        Some(luma) => {
            let color_dist = GaussianEuclideanColorDistance::new(sigma_color as f32);
            let res = imageproc::filter::bilateral_filter(&luma, radius as u8, sigma_spatial as f32, color_dist);
            let dims = array.dimensions();
            let h = dims[0];
            let w = dims[1];
            NumericArray::<u8>::from_array(&[h, w, 1], &res.into_raw())
        },
        None => NumericArray::<u8>::from_slice(&[])
    }
}

#[export]
fn filter_laplacian_memory(array: &NumericArray<u8>) -> NumericArray<i16> {
    match to_luma(array) {
        Some(luma) => {
            let res = imageproc::filter::laplacian_filter(&luma);
            let dims = array.dimensions();
            let h = dims[0];
            let w = dims[1];
            NumericArray::<i16>::from_array(&[h, w, 1], &res.into_raw())
        },
        None => NumericArray::<i16>::from_slice(&[])
    }
}

#[export]
fn filter_integral_image_memory(array: &NumericArray<u8>) -> NumericArray<u32> {
    match to_luma(array) {
        Some(luma) => {
            let res: image::ImageBuffer<image::Luma<u32>, Vec<u32>> = imageproc::integral_image::integral_image(&luma);
            let h = res.height() as usize;
            let w = res.width() as usize;
            NumericArray::<u32>::from_array(&[h, w, 1], &res.into_raw())
        },
        None => NumericArray::<u32>::from_slice(&[])
    }
}

#[export]
fn filter_integral_squared_image_memory(array: &NumericArray<u8>) -> NumericArray<u64> {
    match to_luma(array) {
        Some(luma) => {
            let res: image::ImageBuffer<image::Luma<u64>, Vec<u64>> = imageproc::integral_image::integral_squared_image(&luma);
            let h = res.height() as usize;
            let w = res.width() as usize;
            NumericArray::<u64>::from_array(&[h, w, 1], &res.into_raw())
        },
        None => NumericArray::<u64>::from_slice(&[])
    }
}
