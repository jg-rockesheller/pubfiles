const expect = @import("std").testing.expect;

test "labelled blocks" {
    const count = blk: {
        var sum: u32 = 0;
        var i: u32 = 0;
        while (i < 10) : (i += 1) sum += i;
        break :blk sum; // I'm guessing this is kinda like a return
    };

    try expect(count == 45);
    try expect(@TypeOf(count) == u32);
}

// like blocks, loops can be given labels, allowing for breaks and continues
// for outer loops

test "nested continue" {
    var count: usize = 0;
    outer: for ([_]i32{ 1, 2, 3, 4, 5, 6, 7, 8 }) |_| {
        for ([_]i32{ 1, 2, 3, 4, 5 }) |_| {
            count += 1;
            continue :outer;
        }
    }

    try expect(count == 8);
}
