import gleam/io

pub fn main() {
  let add_one = fn(x) { x + 1 }
  let exclaim = fn(x) { x <> "!" }
  // `<>` is string concatenation

  // this will fail because 10 is an int and exclaim takes in a string
  // twice(10, exclaim)

  io.debug(twice(10, add_one))
  io.debug(twice("Hello", exclaim))
}

// the `value` will be replaced by the type of whatever we pass into the function
fn twice(argument: value, my_function: fn(value) -> value) -> value {
  my_function(my_function(argument))
}