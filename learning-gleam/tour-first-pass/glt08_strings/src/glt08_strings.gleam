import gleam/io
import gleam/string

// like in other languages, strings in Gleam are surrounded by double quotes
// can span multiple lines and can contain unicode characters

pub fn main() {
  // unicode / emoji support
  io.debug("👩‍💻 こんにちは Gleam 🏳️‍🌈")
  io.debug(
    "multi
    line
    strings", // there has to be a common here
  )

  // many escape sequences work the same
  io.debug("hello\n")
  io.debug("first\tlast")
  io.debug("backslash \\")
  io.debug("\u{1F600}") // specify your own unicode codepoint

  // the `gleam/string` module provides common string functions
  io.debug(string.reverse("1 2 3 4 5"))
  io.debug(string.append("abc", "def"))
}