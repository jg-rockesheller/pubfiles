const expect = @import("std").testing.expect;

test "while" {
    var i: u8 = 2;

    // like a normal while loop
    while (i < 100) {
        i *= 2;
    }

    try expect(i == 128);
}

test "while with continue expression" {
    var sum: u8 = 0;
    var i: u8 = 1;

    // kinda like a for-loop
    // also, we can do the C thing where if it's just one expression inside the
    // loop, we can omit the curly braces and even make it inline
    while (i <= 10) : (i += 1) sum += i;

    try expect(sum == 55);
}

// we have `continue` and `break` like in other languages

test "while with continue" {
    var sum: u8 = 0;
    var i: u8 = 0;

    while (i <= 3) : (i += 1) {
        if (i == 2) continue;
        sum += i;
    }

    try expect(sum == 4);
}

test "while with break" {
    var sum: u8 = 0;
    var i: u8 = 0;

    while (i <= 3) : (i += 1) {
        if (i == 2) break;
        sum += i;
    }

    try expect(sum == 1);
}
