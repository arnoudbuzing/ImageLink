use wolfram_library_link::{export, NumericArray};
use image::{ImageBuffer, Rgb, Rgba};
use ab_glyph::{FontRef, PxScale};

#[export]
fn drawing_get_version() -> String {
    "0.1.0".to_string()
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
