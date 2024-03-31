const expect = @import("std").testing.expect;
// zig has enums just like in C

const Direction = enum { north, south, east, west };
// you can specify (integer) tag types
const Value = enum(u2) { zero, one, two };
// I didn't know you could do this! an integer with just 2 bits!

// enum's ordinal values start at 0, which can be accessed using `@intFromEnum`
test "enum ordinal value" {
    try expect(@intFromEnum(Value.zero) == 0);
    try expect(@intFromEnum(Value.one) == 1);
    try expect(@intFromEnum(Value.two) == 2);
}

// you can define ordinal values
const Value2 = enum(u32) {
    hundred = 100,
    thousand = 1000,
    million = 1_000_000,
    next,
};

test "set enum ordinal values" {
    try expect(@intFromEnum(Value2.hundred) == 100);
    try expect(@intFromEnum(Value2.thousand) == 1_000);
    try expect(@intFromEnum(Value2.million) == 1_000_000);
    try expect(@intFromEnum(Value2.next) == 1_000_001);
}

// enums can be given methods (wow, wonder if structs have this)
const Suit = enum {
    clubs,
    spades,
    diamonds,
    hearts,

    // can acess like methods from OO languages
    pub fn isClubs(self: Suit) bool {
        return self == Suit.clubs;
    }
};

test "enum method" {
    try expect(Suit.spades.isClubs() == Suit.isClubs(.spades));
}

// enums can also have `var` and `const` fields
const Mode = enum {
    var count: u32 = 0;
    on,
    off,
};

test "hmm" {
    Mode.count += 1;
    try expect(Mode.count == 1);
}
