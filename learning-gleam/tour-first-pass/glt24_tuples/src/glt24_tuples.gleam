import gleam/io

pub fn main() {
  // tuples are like what they are in Haskell
  // defined like #(...)
  let triple: #(Int, Float, String) = #(1, 2.2, "three")
  io.debug(triple)

  // to access data in a tuple, use a `.`
  // indexing starts at 0
  io.debug(triple.1)

  // to extract individual values from a tuple:
  let #(a, _, _): #(Int, _, _) = triple
  io.debug(a)
}