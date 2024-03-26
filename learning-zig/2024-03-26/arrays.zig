const std = @import("std");

pub fn main() void {
    // arrays are defined like [N]T:
    // N represents the number of elements in the array
    // _ can be used in place of N to infer the size of an array at assignment
    // T is the type of the elements in the array

    // when annotating the type, you must have the size of the array
    const a: [5]u8 = [5]u8{ 'h', 'e', 'l', 'l', 'o' };
    // you can get the length of an array using the `len` field
    // I guess this means that arrays are a type of struct
    const a_len = a.len;
    std.debug.print("the length of array `a` is: {d}\n", .{a_len});

    const b = [_]u16{ 69, 420 };
    // I'm assuming you index arrays like you do in other languages
    // also 0 indexing, as standard
    std.debug.print("the first element of array `b` is: {d}\n", .{b[0]});
}
