use image::{ImageBuffer, Luma};
use imageproc::morphology::dilate;
use imageproc::distance_transform::Norm;

fn main() {
    let mut img = ImageBuffer::<Luma<u8>, _>::new(5, 5);
    img.put_pixel(2, 2, Luma([255]));

    let dilated = dilate(&img, Norm::LInf, 1);
    
    println!("Dilated:");
    for y in 0..5 {
        for x in 0..5 {
            print!("{:3} ", dilated.get_pixel(x, y)[0]);
        }
        println!();
    }
}
