import gleam/io
import gleam/result

pub fn main() {
  io.debug(without_use())
  io.debug(with_use())

  // use a, b <- my_function()
  // next(a)
  // next(b)
  // expands into:
  // my_function(fn (a, b) {
  //   next(a)
  //   next(b)
  // })
}

pub fn without_use() {
  result.try(get_username(), fn(username) {
    result.try(get_password(), fn(password) {
      result.map(log_in(username, password), fn(greeting) {
        greeting <> ", " <> username
      })
    })
  })
}

// use `use` when doing a bunch of `result.try` (this is pretty common)
// they have to be used in succession of each other because they basically evaluate into a single anonymous function
pub fn with_use() {
  use username <- result.try(get_username())
  use password <- result.try(get_password())
  use greeting <- result.map(log_in(username, password))
  greeting <> ", " <> username
}

fn get_username() {
  Ok("alice")
}

fn get_password() {
  Ok("hunter2")
}

fn log_in(_username: String, _password: String) {
  Ok("Welcome")
}
