import gleam/io
import gleam/int
import gleam/list

pub fn main() {
  let x = int.random(5)
  io.debug(x)

  // the case statement is like switch, but with pattern matching
  // evaluates to an expression
  let result = case x {
    0 -> "Zero"
    1 -> "One"
    _ -> "Other"
  }
  io.debug(result)

  let result_v2 = case int.random(5) {
    0 -> "Zero"
    1 -> "One"

    // we can assign any other value to the `other` name
    other -> "It is " <> int.to_string(other)
  }
  io.debug(result_v2)

  "Hello, world!"
  |> get_name
  |> io.debug

  "System still working?"
  |> get_name
  |> io.debug

  // we can use case statements with multiple values
  case int.random(2), int.random(2) {
    0, 0 -> "Both are zero"
    0, _ -> "First is zero"
    _, 0 -> "Second is zero"
    _, _ -> "Neither are zero"
  }
  |> io.debug

  // pattern matching checks based on both structure and value
  case list.repeat(int.random(5), times: int.random(3)) {
    [] -> "Empty list"
    [1] -> "List of just 1"
    [4, ..] -> "List starting with 4"
    [_, _] -> "List of 2 elements"
    _ -> "Some other list"
  }
  |> io.debug

   // you can do basically an `or` using case statements
   case int.random(10) {
    2 | 4 | 6 | 8 -> "even number"
    1 | 3 | 5 | 7 -> "odd number"
    _ -> "not sure"
   }
   |> io.debug
}

fn get_name(x: String) -> String {
  // pattern matching checks based on both structure and value
  case x {
    "Hello, " <> name -> name
    _ -> "Unknown string"
  }
}