use wolfram_library_link::NumericArray;

pub fn test_array(array: &NumericArray<u8>) -> usize {
    let dims = array.dimensions();
    dims.len()
}
