#include <iostream>
// as noted in `hello.cpp`, `<iostream>` is part of the C++ standard library
// that deals with basic input and output, like C's `<stdio.h>`

int main(void) {
  std::cout << "Hello, world!\n"; // like in C, we have to include the '\n'
                                  // character, as it's not there by default

  // we can also use multiple insertions together on the same line
  // notice how the `10` is not in quotes and is just the int literal
  std::cout << "Codeacademy is " << 10 << " years old." << std::endl;
  // also, `std::endl` can be used to insert a new line

  int x = 0; // this variable declaration is just like C
  std::cout << "Please enter a number: ";
  std::cin >> x; // we are using `>>`, whereas for `cout` we used `<<`
                 // I think of this like the direction of where we receive
                 // If something with an invalid type is passed into `x`, it
                 // will go to its default value, in this case, `0`
  std::cout << x << std::endl;

  // we can also print and receive multiple variables
  int y, z = 0;
  std::cout << "Please enter two numbers:" << std::endl;
  std::cin >> y >> z;
  std::cout << y << " and " << z << std::endl;

  return 0;
}
