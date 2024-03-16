import gleam/io

// List is a generic type, having another type as a parameter
// they are immutable and are singly-linked lists

pub fn main() {
  let ints: List(Int) = [1, 2, 3]
  io.debug(ints)

  // because lists are immutable, we cannot just append/prepend them with a method
  // instead we have to do something like this:
  let ints2: List(Int) = [-1, 0, ..ints]
  io.debug(ints2)

  // io.debug(["zero", ..ints])
  // this fails because lists can only contain one type

  // the original `ints` list is unchanged
  io.debug(ints)
}