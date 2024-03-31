const expect = @import("std").testing.expect;

// slices are like a pair of `[*]T` (many-item pointer to data) and a `usize`
// (the element count), they are defined with a type of `[]T`, with `T` being
// the child type
// string literals turn coerce to `[]const u8`

fn total(values: []const u8) usize {
    var sum: usize = 0;
    for (values) |v| sum += v;
    return sum;
}

test "slices" {
    const array = [_]u8{ 1, 2, 3, 4, 5 };
    // the x[n..m] syntax is used to make a slice from an array
    // this will create a slice cotaining the values from array[0] to array[2]
    const slice = array[0..3];

    try expect(total(slice) == 6);
}

test "slices 2" {
    const array = [_]u8{ 1, 2, 3, 4, 5 };
    const slice = array[0..3];

    // when `n` and `m` are known at compile tiem, slicing will actually
    // result in a pointer to an array, however, pointers to arrays can coerce
    // to slices
    try expect(@TypeOf(slice) == *const [3]u8);
}

test "slices 3" {
    var array = [_]u8{ 1, 2, 3, 4, 5 };
    // you can also you `x[n..]` to slice from the `n`th index to the end of
    // the array
    var slice = array[0..];
    _ = slice;
}
