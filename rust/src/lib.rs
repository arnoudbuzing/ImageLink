use wolfram_library_link::export;
use image::imageops::FilterType;

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
