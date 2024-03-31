const expect = @import("std").testing.expect;

// inline loops are unrolled
test "inline for" {
    const types = [_]type{ i32, f32, u8, bool };
    var sum: usize = 0;

    // allows some things to happen that only work at comp time
    inline for (types) |T| sum += @sizeOf(T);

    try expect(sum == 10);
}
