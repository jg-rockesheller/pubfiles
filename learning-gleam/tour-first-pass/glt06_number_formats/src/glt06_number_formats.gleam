import gleam/io

// underscores can be used to make large numbers easier to read
// additionally, ints can be written in binary, octal, or hex using:
// 0b, 0o, 0x
// floats can be written in scientific notation

pub fn main() {
  io.debug(1000000)
  io.debug(1_000_000)

  io.debug(10000.01)
  io.debug(10_000.01)

  io.debug(0b00110011) // 51
  io.debug(0o17) // 15
  io.debug(0xC) // 12

  io.debug(7.0e3)
  io.debug(3.0e-4)
}