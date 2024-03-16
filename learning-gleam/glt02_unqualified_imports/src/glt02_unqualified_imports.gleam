import gleam/io.{println}
// we can use `println` in both a qualified and unqualified action

pub fn main() {
  io.println("qualified function call")
  println("unqualified function call")
}

// it is best practice to use qualified imports