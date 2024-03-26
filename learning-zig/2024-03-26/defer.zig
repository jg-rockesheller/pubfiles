const expect = @import("std").testing.expect;

test "defer" {
    var x: i16 = 5;

    // defer is used to execute statements while exiting the current block

    // inline blocks can be defined with curly braces
    {
        defer x += 2;
        try expect(x == 5); // this will succeed because the x += 2 expression
        // hasen't evaluated yet, it will after this is run
        // and while this block is exiting
    }

    try expect(x == 7);
}

test "multi defer" {
    var x: f32 = 5;

    // when there are multipledefers, they are evaluated in reverse order
    {
        defer x += 2;
        defer x /= 2; // this will run before the above
    }

    try expect(x == 4.5);
}
