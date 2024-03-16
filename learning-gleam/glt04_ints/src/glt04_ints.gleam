import gleam/io
import gleam/int

// ints work like they do in other languages, they are whole numbers
// on a BEAM VM, there is no max / min size
// on a JS runtime, the ints are like 64-bit floating points numbers

pub fn main() {
  // basic arithmatic
  io.debug(1 + 1)
  io.debug(5 - 1)
  // im guessing on a BEAM VM, division would be int division
  // but on a JS runtime, it would convert to a float
  io.debug(5 / 2)
  io.debug(3 * 3)
  io.debug(5 % 2)

  // comparisons return bools
  io.debug(2 > 1)
  io.debug(2 < 1)
  io.debug(2 >= 1)
  io.debug(2 <= 1)

  // equality works on any two values of the same type
  io.debug(1 == 1)
  io.debug(2 == 1)

  // `gleam/int` is what provides int functions
  io.debug(int.max(42, 77))
  io.debug(int.clamp(5, 10, 20))
}

