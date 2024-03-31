const expect = @import("std").testing.expect;

test "sentinel termination" {
    // arrays, slices, and many pointers can be terminated by a value of their
    // child type
    const terminated = [3:0]u8{ 3, 2, 1 };

    try expect(terminated.len == 3);
    try expect(@as(*const [4]u8, @ptrCast(&terminated))[3] == 0);
}

// string literals are actually sentinel terminated
test "string literal" {
    try expect(@TypeOf("hello") == *const [5:0]u8);
}

test "C string" {
    // this mimics C strings because it can be of any length
    const c_string: [*:0]const u8 = "hello";
    var array: [5]u8 = undefined;

    var i: usize = 0;
    while (c_string[i] != 0) : (i += 1)
        array[i] = c_string[i];
}

// sentinel terminated types coerce to their non-sentinel-terminated versions
test "coercion" {
    var a: [*:0]u8 = undefined;
    const b: [*]u8 = a;
    _ = b;

    var c: [5:0]u8 = undefined;
    const d: [5]u8 = c;
    _ = d;

    var e: [:0]f32 = undefined;
    const f: []f32 = e;
    _ = f;
}

// sentinel terminated slices can be created through slicing
test "sentinel terminated slicing" {
    var x = [_:0]u8{255} ** 3;
    const y = x[0..3 :0]; // means this is a senitel terminated slice
    _ = y;
}
