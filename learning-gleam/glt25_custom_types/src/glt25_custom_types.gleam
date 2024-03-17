import gleam/io
import gleam/int

// this syntax is used to make something like an enum
// the seasons are constructors for each variant of the type
pub type Season {
  Spring
  Summer
  Autumn
  Winter
}

// this is for something like a struct
// a variant can hold other data within it
// a variant that does hold this data is called a record
pub type SchoolPerson {
  // the fields can be given labels
  Teacher(name: String, subject: String)
  // but these labels are optional
  Student(String)
}

pub type SchoolPersonV2 {
  // the fields can be given labels
  TeacherV2(name: String, subject: String)
  // but these labels are optional
  StudentV2(name: String)
}

// we can also create our own generics, taking another type as a parameter
// this is an implementation of `Option`, which is defined in `gleam/option`
// like functors in Haskell
pub type Option(inner) {
  Some(inner)
  None
}

pub type SchoolPersonV3 {
  TeacherV3(name: String, subject: String, floor: Int, room: Int)
}

pub fn main() {
  io.debug(weather(Spring))
  io.debug(weather(Winter))

  let teacher1: SchoolPerson = Teacher("Mr. Schofield", "Physics")
  let teacher2: SchoolPerson = Teacher(name: "Ms. Percy", subject: "Calculus")
  let student1: SchoolPerson = Student("James")
  let student2: SchoolPerson = Student("Sydney")
  let student3: SchoolPerson = Student("Timmy")

  let school = [teacher1, teacher2, student1, student2, student3]
  io.debug(school)

  let teacher_v2: SchoolPersonV2 = TeacherV2("Mr. Schofield", "Physics")
  let student_v2: SchoolPersonV2 = StudentV2("James")
  // we can access fields of a record using `.`
  // however, the field must exist in all variants of the type
  io.debug(teacher_v2.name)
  io.debug(student_v2.name)
  // io.debug(teacher_v2.subject) // this won't work because the `StudentV2` record doesn't have a subject label

  // you can update records using the update syntax (..<original var>)
  let teacher1_v3: SchoolPersonV3 = TeacherV3(name: "Mr Dodd", subject: "ICT", floor: 2, room: 2)
  let teacher2_v3: SchoolPersonV3 = TeacherV3(..teacher1_v3, subject: "PE", room: 6)
  io.debug(teacher1_v3)
  io.debug(teacher2_v3)
  // only works if there is only one variant in the type, otherwise it would have to be wrapped in a case statement

  let name: Option(String) = Some("a test string")
  let level: Option(Int) = Some(5)
  let nothing: Option(Float) = None
  io.debug(name)
  io.debug(level)
  io.debug(nothing)

  // Nil is what is returned by functions that don't return anything
  // Nil is not a valid value for any other type other than Nil
  let x: Nil = Nil
  io.debug(x)
  let result = io.println("Hello!")
  io.debug(result == Nil)
  // let y: List(String) = Nil // will not work because Nil cannot be the value of a string

  // check how Results are returned:
  io.debug(buy_pastry(10))
  io.debug(buy_pastry(8))
  io.debug(buy_pastry(5))
  io.debug(buy_pastry(3))

  // bit arrays are useful for managing binary data
  // we can specify what representation is used for a segment of a bit array
  io.debug(<<3>>) // is equal to 3 as an 8 bit int (00000011)
  io.debug(<<3>> == <<3:size(8)>>) // size defined the size of the segment in bits
  io.debug(<<6147:size(16)>>)
  io.debug(<<"Hello, Joe!":utf8>>)

  // very little support when compiling to JS
}

fn weather(season: Season) -> String {
  case season {
    Spring -> "Mild"
    Summer -> "Hot"
    Autumn -> "Windy"
    Winter -> "Cold"
  }
}

// instead of exceptions, Gleam handles errors using Results
// Results have two variants:
// Ok, containing the return value of a successful operation
// Error, which contains the reason for a failed computation
// this is good because you can wrap information about an error in what is returned with the error
pub type PurchaseError {
  NotEnoughMoney(required: Int)
  NotLuckyEnough
}

fn buy_pastry(money: Int) -> Result(Int, PurchaseError) {
  case money >= 5 {
    True ->
      case int.random(4) == 0 {
        True -> Error(NotLuckyEnough)
        False -> Ok(money - 5)
      }
    False -> Error(NotEnoughMoney(required: 5))
  }
}