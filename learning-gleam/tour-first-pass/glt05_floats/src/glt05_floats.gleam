import gleam/io
import gleam/float

// floats are for any numbers that are not ints, like in other languages
// operators do not overlap between floats and ints
// there are special operations for floats (the int operators with a `.` after)

// floats are represented as 64 bit floating point numbers on both Erlang and JS runtimes
// under JS, over/under flowing will result in an `Infinity` or `-Infinity` value
// under BEAM, it would raise an error
// dividing by zero results in zero (for floats)

pub fn main() {
  // floating point arithmetic
  io.debug(1.0 +. 1.5)
  io.debug(5.0 -. 1.5)
  io.debug(5.0 /. 2.5)
  io.debug(3.0 *. 3.5)

  // dividing by zero
  io.debug(3.14 /. 0.0)

  // compaisons are also suffixed with a `.`
  io.debug(1.0 <=. 1.5)
  io.debug(1.5 >=. 30.6)

  // however, equality "==" is always the same for any type
  io.debug(1.1 == 1.1)
  io.debug(3.14 == 6.28)

  // like `gleam/int`, there is a `gleam/float`
  io.debug(float.max(2.0, 9.5))
  io.debug(float.ceiling(5.4))
}

// no operator overloading! (very, very nice)