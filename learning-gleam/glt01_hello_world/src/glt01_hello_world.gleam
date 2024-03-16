import gleam/io

// this imports a module from the standard library
// `gleam/` means we are in Gleam's standard library namespace
// `io` is the module from the standard library being imported

pub fn main() {
  io.println("Hello, world!") // no semicolons!
  // because there's a `println`, there should be a `print`
  io.print("Hello, Mike!\n")
}
// using `main()` like other compiled languages