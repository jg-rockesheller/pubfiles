# Learning Gleam

A run-through of the [Tour of Gleam](https://tour.gleam.run) and the [Exercism course](https://exercism.org/tracks/gleam).

Bookmark: [Tour: Advanced Features: Use (First Pass)](https://tour.gleam.run/advanced-features/use/)

## 2024.03.16

The first pass of the tour.

### Basics

* Finished `Basics` part of the tour.
* Makes sense so far
* I know this is an impure functional language but it is still weird seeing mutable variables
* Pretty simple, a lot of the syntax and concepts are the same as other languages, unlike Haskell
* I really like no opeartor overloading for ints and floats

### Functions

* Pipelines are super nice!
* I feel like I understand the function captures more because I understand currying from Haskell.
* Labeled arguments seem like a very, very useful feature for readability

### Flow Control

* Pretty similar to Haskell flow control
* Pattern matching is amazing and is very powerful
* I like how flow control is basically just a switch statement
  * Unlike Haskell, which has pattern matching both in just function defintions and in where expressions, as well as guards
    * In Gleam, this all falls under case expressions
* I think I understand the difference between

### Data Types

* I thought this was way easier to reason about compared to Haskell's type system
  * Might just because the book explained it too strangely
* Comparing variants to enums and records to structs makes alot of sense
* I think `Results` are the best things in the world for error handling

### Standard Library

* Mostly quality of life things
* If I need anything, at least there are good docs