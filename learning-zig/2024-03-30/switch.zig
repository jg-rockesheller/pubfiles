const expect = @import("std").testing.expect;

test "switch statement" {
    var x: i8 = 10;

    // like a case statement from any other language
    switch (x) {
        -1...1 => {
            x = -x;
        },

        10, 100 => {
            x = @divExact(x, 10);
        },

        else => {},
    }

    try expect(x == 1);
}

test "switch expression" {
    var x: i8 = 1;

    // here is switch being used like an expression
    x = switch (x) {
        -1...1 => -x,
        10, 100 => @divExact(x, 10),
        else => x,
    };

    try expect(x == -1);
}
