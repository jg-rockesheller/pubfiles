import gleam/io

// we can pass and return functions as values

pub fn main() {
  io.debug(twice(1, add_one))

  // functions can be assigned as values
  let my_function = add_one
  io.debug(my_function(100))
}

// twice takes in an argument and a function and runs the function twice
fn twice(argument: Int, passed_function: fn(Int) -> Int) -> Int {
  passed_function(passed_function(argument))
}

fn add_one(argument: Int) -> Int {
  argument + 1
}