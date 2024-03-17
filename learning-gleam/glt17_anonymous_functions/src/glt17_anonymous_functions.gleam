import gleam/io

// anonymous functions allow for function to be defined inside other functions

pub fn main() {
  // they are kinda like blocks
  let add_one = fn(a) { a + 1 }
  io.debug(twice(1, add_one))

  // anonymous functions can also be used as function arguments
  io.debug(twice(1, fn(a) { a * 2 }))
}

fn twice(argument: Int, my_function: fn(Int) -> Int) -> Int {
  my_function(my_function(argument))
}