import gleam/io

// `fn` is used to define new functions
// if `pub` is not used, then the functions are private and only usable within the module their defined
// type annotations are optional for function arguments and return values, but are good practice

pub fn main() {
  io.debug(double(10))
}

fn double(a: Int) -> Int {
  multiply(a, 2)
}

fn multiply(a: Int, b: Int) -> Int {
  a * b
}

// there is not `return` keyword, so I'm assuming that the last expression is what is returned