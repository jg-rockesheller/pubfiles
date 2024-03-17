import gleam/io

pub fn main() {
  print_score(10)
  print_score(100_000)
  print_score(-1)
}

pub fn print_score(score: Int) {
  case score {
    score if score > 1000 -> io.println("High score!")
    score if score > 0 -> io.println("Still working on it")
    // `panic` is used to crash the program when it reaches a point that should never be reached
    _ -> panic as "Scores should never be negative!"
  }
}