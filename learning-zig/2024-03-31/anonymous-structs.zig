const expect = @import("std").testing.expect;

test "anonymous struct literal" {
    const Point = struct { x: i32, y: i32 };

    // the struct type may be omitted from a struct literal
    var pt: Point = .{
        .x = 13,
        .y = 67,
    };

    try expect(pt.x == 13);
    try expect(pt.y == 67);
}

// you can create a struct that doesn't coerce to another struct type
test "fully anonymous struct" {
    try dump(.{
        .int = @as(u32, 1234),
        .float = @as(f64, 12.34),
        .b = true,
        .s = "hi",
    });
}

fn dump(args: anytype) !void {
    try expect(args.int == 1234);
    try expect(args.float == 12.34);
    try expect(args.b == true);
    try expect(args.s[0] == 'h');
    try expect(args.s[1] == 'i');
}

// anonymous structs without field names are called `tuples`
// these can be iterated over, indexed, and have the `++` and `**` applied
test "tuple" {
    const values = .{
        @as(u32, 1234),
        @as(f64, 12.34),
        true,
        "hi",
    } ++ .{false} ** 2;

    try expect(values[0] == 1234);
    try expect(values[4] == false);

    // an inline loop must be used to iterate over a tuple, because the types
    // inside it may very
    inline for (values, 0..) |v, i| {
        if (i != 2) continue;
        try expect(v);
    }

    try expect(values.len == 6);
    try expect(values.@"3"[0] == 'h');
}
