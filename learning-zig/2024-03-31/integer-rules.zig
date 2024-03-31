const expect = @import("std").testing.expect;

// zig supports hex, octal, and binary integers
// it also supports placing underscores between digits as a visual separator
const decimal_int: i32 = 98222;
const hex_int: u8 = 0xff;
const another_hex_int: u8 = 0xFF;
const octal_int: u16 = 0o755;
const binary_int: u8 = 0b11110000;
const one_billion: u64 = 1_000_000_000;
const binary_mask: u64 = 0b1_1111_1111;
const permissoins: u64 = 0o7_5_5;
const big_address: u64 = 0xFF80_0000_0000_0000;

test "integer widening" {
    // integers of a type may coerce into an integer from another type, as long
    // as it fits within the parameters
    const a: u8 = 250;
    const b: u16 = a;
    const c: u32 = b;

    try expect(c == a);
}

// `@intCast` is also used to explicitely convert from one int type to another
// is the value is out of range of the destination type, then it is illegal
test "@intCast" {
    const x: u64 = 200;
    const y = @as(u8, @intCast(x));
    try expect(@TypeOf(y) == u8);
}

// integers will not overflow by default
test "well defined overflow" {
    var a: u8 = 255;
    a +%= 1; // use a `%` to explicitely overflow
    try expect(a == 0);
}
