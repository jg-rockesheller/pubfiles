const std = @import("std");

pub fn main() void {
    // assignment follows this format:
    // (const|var) identifier[: type] = value
    // `const` means the `identifier` is constant
    // `var` means that `identifier` is a mutable variable
    // the type can be ommitted if the type can be inferred

    // if a value is not used, the compiler will complain
    // const constant: i32 = 5;
    var variable: u32 = 5000;

    // `@as` is used for explicit type coercion
    const inferred_constant = @as(i32, 5);
    // var inferred_variable = @as(u32, 5000);

    // I'm guessing this is how to print out `ints`
    std.debug.print("variable initial value: {d}\n", .{variable});
    variable = 5001; // of course, variables can be reassigned
    std.debug.print("variable initial value: {d}\n", .{variable});
    std.debug.print("constant value: {d}\n", .{inferred_constant});

    // variables must have a value
    // `undefined` can be used as long as a tyep annotation is provided
    const a: i32 = undefined;
    std.debug.print("undefined integer: {d}\n", .{a});
    // this looks like a random number
}
