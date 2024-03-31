const expect = @import("std").testing.expect;

// unions allow for values to be stored as a variety of types

const Result = union {
    int: i64,
    float: i64,
    bool: bool,
};

// only one type field may be actice at one time
test "simple union" {
    var result = Result{ .int = 1234 };
    // result.float = 12.34;
    _ = result;
}

// tagged unions are unions which use an enum to detect which type field is
// active

const Tag = enum { a, b, c };
const Tagged = union(Tag) { a: u8, b: f32, c: bool };

test "switch on tagged union" {
    var value = Tagged{ .b = 1.5 };
    switch (value) {
        // use |*value| syntax to capture the pointer to the value in the field
        .a => |*byte| byte.* += 1,
        .b => |*float| float.* *= 2,
        .c => |*b| b.* = !b.*,
    }

    try expect(value.b == 3);
}

// the type of a tagged union can be inferred
const Tagged2 = union(enum) { a: u8, b: f32, c: bool };
// `void` member types can have their type omitted
const Tagged3 = union(enum) { a: u8, b: f32, c: bool, none };
