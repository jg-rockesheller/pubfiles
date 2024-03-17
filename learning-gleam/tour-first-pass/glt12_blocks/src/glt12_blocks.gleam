import gleam/io

// expressions are like what they are in Haskell

pub fn main() {
  // expressions can be grouped together with curly braces
  let fahrenheit = {
    let degrees: Int = 64
    degrees
  }
  // you cannot do:
  // io.debug(degrees)
  // because `degrees` is out of scope
  // but you can do:
  io.debug(fahrenheit)

  // curly braces also change the order of evaluation for expressions
  let celcius = { fahrenheit - 32 } * 5 / 9
  io.debug(celcius)
}