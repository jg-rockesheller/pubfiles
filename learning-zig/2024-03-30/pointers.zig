const expect = @import("std").testing.expect;

// pointer types follow the pattern `*T` where `T` is the child type
fn increment(num: *u8) void {
    // kinda just realized that pointers are like a type of functor
    num.* += 1; // `.*` is used to dereference a pointer
}

test "pointers" {
    var x: u8 = 1;
    increment(&x); // to reference, use an `&`, like in C
    try expect(x == 2);
}

test "const pointers" {
    const x: u8 = 1;
    var y = &x;
    // this won't work because pointers to constant values don't allow you to
    // modify the original variable
    y.* += 1;
}

test "psize" {
    // `usize` and `isize` are integers that are the same size of pointers
    try expect(@sizeof(usize) == @sizeof(*u8));
    try expect(@sizeof(isize) == @sizeof(*i8));
}
