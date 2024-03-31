const expect = @import("std").testing.expect;
const eql = @import("std").mem.eql;

fn fibonacci(n: u32) u32 {
    if (n <= 1) {
        return 1;
    } else {
        return fibonacci(n - 1) + fibonacci(n - 2);
    }
}

test "comptime blocks" {
    var x = comptime fibonacci(10);
    _ = x;

    // the `comptime` keyword is used to force a block to run at compile time
    var y = comptime blk: {
        break :blk fibonacci(10);
    };
    _ = y;
}

// int literals have the type `comptime_int` and technically have no size
// they coerce into any integer or float type that can hold them
test "comptime_int" {
    const a = 12;
    const b = a + 10;

    const c: u4 = a;
    _ = c;
    const d: f32 = b;
    _ = d;
}
// `comptime_float` is kinda like the above

test "branching on types" {
    const a = 5;
    // type can be assigned conditionally
    const b: if (a < 10) f32 else i32 = 5;
    _ = b;
}

// types are values of type `type`
// function parameters in Zig can be tagged as `comptime`, meaning that the
// value must be known at compile time
fn Matrix(
    comptime T: type,
    comptime width: comptime_int,
    comptime height: comptime_int,
) type {
    return [height][width]T;
}

test "returning a type" {
    // we must pass in the values as literals, which are known at runtime
    try expect(Matrix(f32, 4, 4) == [4][4]f32);
}

// `@typeInfo` is used to reflect upon types, returning a tagged union
// `@compileError` is used to define a compile time error message
fn addSmallInts(comptime T: type, a: T, b: T) T {
    return switch (@typeInfo(T)) {
        .ComptimeInt => a + b,
        .Int => |info| if (info.bits <= 16)
            a + b
        else
            @compileError("ints too large"),
        else => @compileError("only ints accepted"),
    };
}

test "typeinfo switch" {
    const x = addSmallInts(u16, 20, 30);
    try expect(@TypeOf(x) == u16);
    try expect(x == 50);
}

// `@Type` is used to return a new type from `@typeInfo`
fn GetBiggerInt(comptime T: type) type {
    return @Type(.{
        .Int = .{
            .bits = @typeInfo(T).Int.bits + 1,
            .signedness = @typeInfo(T).Int.signedness,
        },
    });
}

test "@Type" {
    try expect(GetBiggerInt(u8) == u9);
    try expect(GetBiggerInt(i31) == i32);
}

// returning a struct type is how generic data structures are made in Zig
fn Vec(comptime count: comptime_int, comptime T: type) type {
    return struct {
        data: [count]T,
        // `@This` gets the type of the innermost struct, union, or enum
        const Self = @This();

        fn abs(self: Self) Self {
            var tmp = Self{ .data = undefined };
            for (self.data, 0..) |elem, i| {
                tmp.data[i] = if (elem < 0)
                    -elem
                else
                    elem;
            }

            return tmp;
        }

        fn init(data: [count]T) Self {
            return Self{ .data = data };
        }
    };
}

test "generic vector" {
    const x = Vec(3, f32).init([_]f32{ 10, -10, 5 });
    const y = x.abs();
    try expect(eql(f32, &y.data, &[_]f32{ 10, 10, 5 }));
}

// `@TypeOf` can be run on a parameter in a function's return signature
fn plusOne(x: anytype) @TypeOf(x) {
    return x + 1;
}

test "inferred function parameter" {
    try expect(plusOne(@as(u32, 1)) == 2);
}

// comptime also introduces `++` and `**`, which only work at compile time
test "++" {
    // `++` concatenates
    const x: [4]u8 = undefined;
    const y = x[0..];

    const a: [6]u8 = undefined;
    const b = a[0..];

    const new = y ++ b;
    try expect(new.len == 10);
}

test "**" {
    // `**` repeats a slice or array
    const pattern = [_]u8{ 0xCC, 0xAA };
    const memory = pattern ** 3;
    try expect(eql(u8, &memory, &[_]u8{ 0xCC, 0xAA, 0xCC, 0xAA, 0xCC, 0xAA }));
}
