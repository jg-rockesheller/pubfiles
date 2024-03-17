import gleam/io

pub type DateTime

// this will change what the `now()` function is based on which runtime we are using
@external(erlang, "calendar", "local_time")
@external(javascript, "./my_package_ffi.mjs", "now") // this now() function is defined in ./my_package_ffi.mjs
pub fn now() -> DateTime

// there can be both a Gleam and external implementation of something
@external(erlang, "lists", "reverse") // if this function exists, then it will be used
// if not, the following defintiion is used:
pub fn reverse_list(items: List(e)) -> List(e) {
  tail_recursive_reverse(items, [])
}
fn tail_recursive_reverse(items: List(e), reversed: List(e)) -> List(e) {
  case items {
    [] -> reversed
    [first, ..rest] -> tail_recursive_reverse(rest, [first, ..reversed])
  }
}

pub fn main() {
  io.debug(now())

  io.debug(reverse_list([1, 2, 3, 4, 5]))
  io.debug(reverse_list(["a", "b", "c", "d", "e"]))
}