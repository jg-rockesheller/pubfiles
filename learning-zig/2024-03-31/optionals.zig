const expect = @import("std").testing.expect;

// optionals use the syntax `?T`
// they either contain `null` or a value of type `T`
// like `maybe` from Haskell

test "optional" {
    var found_index: ?usize = null;
    const data = [_]i32{ 1, 2, 3, 4, 5, 6, 7, 8, 12 };

    for (data, 0..) |v, i| {
        if (v == 10) found_index = i;
    }

    try expect(found_index == null);
}

test "orelse" {
    var a: ?f32 = null;
    // `orelse` is used to evaluate an expression when something is `null`
    var b = a orelse 0;

    try expect(b == 0);
    try expect(@TypeOf(b) == f32);
}

test "orelse unreachable" {
    // `.?` is a shorthand for `orelse unreachable`
    const a: ?f32 = 5;
    const b = a orelse unreachable;
    const c = a.?;

    try expect(b == c);
    try expect(@TypeOf(c) == f32);
}

test "if optional payload capture" {
    const a: ?i32 = 5;

    if (a != null) {
        const value = a.?;
        _ = value;
    }

    // this basically does the same thing as above
    // when payload capturing optionals, `null` values are ignored
    var b: ?i32 = 5;
    if (b) |*value| value.* += 1;

    try expect(b.? == 6);
}

var numbers_left: u32 = 4;
fn eventuallyNullSequence() ?u32 {
    if (numbers_left == 0) return null;
    numbers_left -= 1;

    return numbers_left;
}

test "while null capture" {
    var sum: u32 = 0;

    // will continue until `value` is `null`
    while (eventuallyNullSequence()) |value| {
        sum += value;
    }

    try expect(sum == 6);
}
