import gleam/io
import gleam/bool

// bools work like they do in other languages
// Gleam has "||", "&&", and "!", which are left-evaluated

pub fn main() {
  io.debug(True && False)
  io.debug(False || True)
  io.debug(!False)

  // `gleam/bool` provides functions for working with bools
  io.debug(bool.to_string(True))
  io.debug(bool.to_int(False))
}