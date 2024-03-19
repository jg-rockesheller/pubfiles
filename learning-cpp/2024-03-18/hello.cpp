// this is both a test for the compiler and notes for program structure

// this is like in C, except `<iostream>` is a C++ library kinda like C's
// `<stdio.h>`
#include <iostream>

// I could do it this way, where I force the `std` namespace on everything
// using namespace std;
// this would allow for using objects from the standard library without
// prepending the `std::` identifier, but this would make it like an
// unqualified import and I think can cause confusion if I use it

// I'm assuming "namespaces" are just a collection of classes, variables, and
// functions, kinda like modules from other languages

// objects from `<iostream>` use the `std` namespace for the standard library

// `main` function like C
// I'm assuming we could use `argc` and `argv`, but I'll check that out later
int main(void) {
  // cout << "Hello, world!\n";   // this is for when I do the thing I
                                  // commented before

  std::cout << "Hello, world!\n"; // however, this I feel like this is more
                                  // readable, as now I know the `cout` object
                                  // comes from the standard libray

  // `return` an `int` like in C
  return 0;
}

// comments are the same as C
/*
this is for multi line comments, again like in C
multi line comments should go above the code they are commenting
*/
