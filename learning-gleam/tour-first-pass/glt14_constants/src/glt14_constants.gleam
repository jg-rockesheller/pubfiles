import gleam/io

// constnats are defined like variables with `let`, but instead with `const`
// they are defined in the highest level scope of a module

// must be literal values; functions cannot be used when defining them
// kinda like type synonyms; except for values

const ints: List(Int) = [1, 2, 3]
const floats: List(Float) = [1.0, 2.0, 3.0]

pub fn main() {
  io.debug(ints)
  io.debug(ints == [1, 2, 3])

  io.debug(floats)
  io.debug(floats == [1.0, 2.0, 3.0])
}