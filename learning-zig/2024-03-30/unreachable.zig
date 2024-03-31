const expect = @import("std").testing.expect;

test "unreachable" {
    const x: i32 = 1;
    // `uncreachable` tells the compiler that this statement will not be
    // reached, and therefore the optimizer can take advantage of it
    const y: u32 = if (x == 2) 5 else unreachable;
    _ = y;
    // reaching somethign that is `unreachable` is detectable illegal behaviour
}

fn asciiToUpper(x: u8) u8 {
    return switch (x) {
        'a'...'z' => x + 'A' - 'a',
        'A'...'Z' => x,
        else => unreachable,
    };
}

test "unreachable switch" {
    try expect(asciiToUpper('a') == 'A');
    try expect(asciiToUpper('A') == 'A');
}
