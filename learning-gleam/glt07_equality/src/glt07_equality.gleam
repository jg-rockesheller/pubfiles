import gleam/io

pub fn main() {
  // the equality operators "==" and "!=" work for any type
  // check for structures (values) rather than memory locations
  io.debug(100 == 100)
  io.debug(1.5 != 0.1)
}