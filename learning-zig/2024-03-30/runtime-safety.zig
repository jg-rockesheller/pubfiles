test "out of bounds" {
    const a = [3]u8{ 1, 2, 3 };
    var index: u8 = 5;
    const b = a[index];
    _ = b;
    // this will cause an "out of bounds" error at compile time
}

test "out of bounds, no safety" {
    // this will disable runtime safety for the current scope
    @setRuntimeSafety(false);
    const a = [3]u8{ 1, 2, 3 };
    var index: u8 = 5;
    const b = a[index];
    _ = b;
    // this would result in unsafe code
}
