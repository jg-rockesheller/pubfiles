const std = @import("std"); // qualified imports

// main function
pub fn main() void {
    // debug.print is the function to print to stdout, I'm guesing
    std.debug.print("Hello, {s}!\n", .{"world"});
}
