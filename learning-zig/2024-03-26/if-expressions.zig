const std = @import("std");
// when taking singular things from a library, we can do this:
const expect = std.testing.expect;

// if statements work like they do in other languages, taking a bool value
// however there are no values that implicitely coerce to a bool

test "if statement" {
    const a = true;
    var x: u16 = 0;
    if (a) {
        x += 1;
    } else {
        x += 2;
    }

    // expect which will cause the test to fail if it's given a `false` value
    try expect(x == 1);
}

test "if statement expression" {
    const a = false;
    var x: u16 = 0;
    x += if (a) 1 else 2;
    // if-else statements can be used as expressions like in Haskell
    try expect(x == 1);
    // in this case, the test will fail because x = 2, not 1
}
