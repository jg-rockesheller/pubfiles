import gleam/io

pub fn main() {
  let a = unsafely_get_first_element([123])
  io.debug(a)

  let b = unsafely_get_first_element([])
  io.debug(b)
}

pub fn unsafely_get_first_element(items: List(a)) -> a {
  // this will panic if the list is empty
  // a normal `let` would cause a compiler error
  // let [first, ..] = items
  // this will cause a panic
  let assert [first, ..] = items
  first
}