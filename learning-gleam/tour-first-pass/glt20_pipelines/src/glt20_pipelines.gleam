import gleam/io
import gleam/int
import gleam/string

pub fn main() {
  // the pipe operator allows for calling a series of functions, passing the result of one to the next
  io.debug(string.drop_left(string.drop_right("Hello, World!", 1), 7))

  // it will go up -> down, asdf
  "Hello, World!"
  |> string.drop_right(1)
  |> string.drop_left(7)
  |> io.debug

  // you can change the order with function capturing
  "a"
  |> string.append("b")
  |> string.append("c", _)
  |> io.debug

  5
  |> int.max(15, _)
  |> int.min(7, _)
  |> io.debug
}