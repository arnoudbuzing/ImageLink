use wolfram_library_link::{export, NumericArray};
use image::{ImageBuffer, Rgb, Rgba};

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
fn vision_get_version() -> String {
    "0.1.0".to_string()
}

#[export]
fn corners_fast9_memory(array: &NumericArray<u8>, threshold: i64) -> NumericArray<i64> {
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

#[export]
fn match_template_memory(array: &NumericArray<u8>, template_array: &NumericArray<u8>, method: i64) -> NumericArray<f64> {
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

#[export]
fn distance_transform_memory(array: &NumericArray<u8>, norm: i64) -> NumericArray<u8> {
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
