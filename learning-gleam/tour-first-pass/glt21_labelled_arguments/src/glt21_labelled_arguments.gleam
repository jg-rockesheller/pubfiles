//// A module that is actually a program file

import gleam/io

// we can annotate the arguments we pass into a function when calling it
pub fn main() {
  io.debug(calculate(1, 2, 3))

  // using labels
  io.debug(calculate(1, add: 2, multiply: 3))

  // using labels in a different order
  io.debug(calculate(1, multiply: 3, add: 2))

  // depends on the situation on whether or not to use labelled arguments

  // calling a deprecated function will result in a warning
  // old_function()
}

// the `addend` argument is labelel as `add`, and the `multiplier` argument is labeled as `multiply`
/// Take in three integers and do some math with them.
///
fn calculate(value: Int, add addend: Int, multiply multiplier: Int) {
  value * multiplier + addend
}

@deprecated("this function is deprecated")
/// This is an example deprecated function
///
fn old_function() {
  Nil
}

/// Is used for documenting types and functions, and should be placed immediately before the type or function it is documenting
//// Is used for documenting modules, and should be placed at the top of the module