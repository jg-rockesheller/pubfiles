import gleam/io

// variables are assigned with `let`
// variables are mutable be default, but their values are not
// values are what are assigned when `let` is used

// let assignements allows for type annotations like in typescript

pub fn main() {
  let x: String = "Original"
  io.debug(x)

  let y: String = x
  io.debug(y)

  // x = "New", but y = "Original" still
  let x = "New"
  io.debug(x)

  io.debug(y)

  // variable is assigned but never used, prefix with a `_` to avoid a warning
  let score: Int = 1000
  let _score: Int = 1000
}

// functions are defined using snake case (kinda sad but ok i guess)