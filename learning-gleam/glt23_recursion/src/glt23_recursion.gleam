import gleam/io

// no loops, just recursion
pub fn main() {
  io.debug(factorial(3))
  io.debug(factorial(5))
  io.debug(factorial(7))

  [18, 56, 35, 85, 91]
  |> sum_list(_, 0)
  |> io.debug

  io.debug(get_first_non_empty([[], [1, 2, 3], [4, 5]]))
  io.debug(get_first_non_empty([[1, 2], [3, 4, 5], []]))
  io.debug(get_first_non_empty([[], [], []]))

  let numbers = [1, 2, 3, 4, 5]
  io.debug(get_first_larger(numbers, 3))
  io.debug(get_first_larger(numbers, 5))
}

// not a tail recursive function because the last last thing the function does is a
// multiplication, so for every time this function is run a new stack frame is created
pub fn factorial(x: Int) -> Int {
  // the case statement is used to check for edge conditions
  case x {
    1 -> 1
    _ -> x * factorial(x - 1)
  }
}

// tail call optimisation is where the compiler is able to reuse the stack frame for the current
// function if a function call is the last thing the function does, removing the memory cost
pub fn factorial_v2(x: Int) -> Int {
  factorial_v2_loop(x, 1)
}

// becasue the last thing the function does is either return a value OR repeat itself with new values,
// this is a tail recursive function, and therefore can be optimized
fn factorial_v2_loop(x: Int, accumulator: Int) -> Int {
  case x {
    1 -> accumulator
    _ -> factorial_v2_loop(x - 1, accumulator * x)
  }
}
// this video explains tail recursion pretty good:
// https://youtu.be/_JtPhF8MshA

pub fn sum_list(list: List(Int), total: Int) {
  case list {
    [first, ..rest] -> sum_list(rest, total + first)
    [] -> total
  }
}

fn get_first_non_empty(lists: List(List(t))) -> List(t) {
  case lists {
    // this expression will match any non-empty list and assign that list tothe variable `first`
    [[_, ..] as first, ..] -> first
    [_, ..rest] -> get_first_non_empty(rest)
    [] -> []
  }
}

fn get_first_larger(lists: List(Int), limit: Int) -> Int {
  // this is the guard in Gleam
  // like Haskell, gets evaluated from the top down
  case lists {
    [first, ..] if first > limit -> first
    [_, ..rest] -> get_first_larger(rest, limit)
    [] -> 0
  }
}