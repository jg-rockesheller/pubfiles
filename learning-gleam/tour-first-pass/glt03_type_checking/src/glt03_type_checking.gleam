import gleam/io

pub fn main() {
  io.println("The number is: ")
  // the following fails because `4` is not of type "String"
  // io.println(4)
  io.debug(4)
  // io.debug works because it can print a value of any type
}

// no `null`! very awesome!
// no exceptions! also very awesome! (i hope this is true even for I/O)
// no implicit conversions!