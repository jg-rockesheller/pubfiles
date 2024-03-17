import gleam/dict
import gleam/int
import gleam/io
import gleam/list
import gleam/result

// we are just importing the types from `gleam/option`
import gleam/option.{type Option, None, Some}

pub fn main() {
  // the Gleam standard library is documented on HexDocs
  // (https://hexdocs.pm/gleam_stdlib/)

  // `gleam/list` functions
  let ints = [0, 1, 2, 3, 4, 5]
  io.debug("============")
  io.debug("=== list ===")
  io.debug("============")

  io.debug("=== map ===")
  ints
  |> list.map(fn(x) { x * 2 })
  |> io.debug

  io.debug("=== filter ===")
  ints
  |> list.filter(fn(x) { x % 2 == 0 })
  |> io.debug

  // `find` returns a Result
  io.debug("=== find ===")
  ints
  |> list.find(fn(x) { x > 3 })
  |> io.debug
  ints
  |> list.find(fn(x) { x > 13 })
  |> io.debug

  // like `foldl` from Haskell
  io.debug("=== fold ===")
  ints
  |> list.fold(0, fn(count, e) { count + e })
  |> io.debug

  // `gleam/result` functions
  io.debug("==============")
  io.debug("=== result ===")
  io.debug("==============")

  io.debug("=== map ===")
  Ok(1)
  |> result.map(fn(x) { x * 2 })
  |> io.debug
  // the function isn't called if the result is an error
  Error(1)
  |> result.map(fn(x) { x * 2 })
  |> io.debug

  // `try` is used to chain together functions that return results
  io.debug("=== try ===")
  Ok("1")
  |> result.try(int.parse)
  |> io.debug
  Ok("no")
  |> result.try(int.parse)
  |> io.debug
  // if `try` receives an error, it will automatically return an error
  Error(Nil)
  |> result.try(int.parse)
  |> io.debug

  // `unwrap` takes out the value from a successful result, and returns a default value if the rseult is an error
  io.debug("=== unwrap ===")
  Ok("1234")
  |> result.unwrap("default")
  |> io.debug
  Error(5)
  |> result.unwrap(0)
  |> io.debug

  // putting things together
  io.debug("=== pipeline ===")
  int.parse("-1234")
  |> result.map(int.absolute_value)
  |> result.try(int.remainder(_, 42))
  |> io.debug
  int.parse("not a number")
  |> result.map(int.absolute_value)
  |> result.try(int.remainder(_, 42))
  |> io.debug

  // `gleam/dict` functions
  // `Dict` is like a dictionary from python
  let scores = dict.from_list([#("Lucy", 15), #("Drew", 18)])
  io.debug(scores)

  // the functions are pretty self explanatory
  let scores = {
    scores
    |> dict.insert("Bushra", 16)
    |> dict.insert("Darius", 14)
    |> dict.delete("Drew")
  }
  io.debug(scores)

  // `gleam/option` module
  // we only imported types from the module in an unqualified way
  let person_with_pet = Person("Al", Some("Nubi"))
  let person_without_pet = Person("Al", None)
  io.debug(person_with_pet)
  io.debug(person_without_pet)
}

pub type Person {
  Person(name: String, pet: Option(String))
}
