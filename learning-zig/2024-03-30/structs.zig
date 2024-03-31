const expect = @import("std").testing.expect;

// structs work kinda like they do in C

const Vec3 = struct { x: f32, y: f32, z: f32 };

test "struct usage" {
    // fields in a struct can be assigned values using this notation:
    const my_vector = Vec3{
        .x = 0,
        .y = 100,
        .z = 50,
    };

    _ = my_vector;
}

// every field of a struct must be initialized:
// test "missing struct field" {
//     const my_vector = Vec3{
//         .x = 0,
//         .z = 50,
//     };
//
//     _ = my_vector;
// }

// however, they can have default values
const Vec4 = struct { x: f32 = 0, y: f32 = 0, z: f32 = 0, w: f32 = 0 };

test "struct defaults" {
    const my_vector = Vec4{
        .x = 25,
        .y = -50,
    };

    _ = my_vector;
}

// when doing methods for structs, one level of dereferencing is done
// automatically when accessing fields
const Stuff = struct {
    x: i32,
    y: i32,
    fn swap(self: *Stuff) void {
        const tmp = self.x;
        self.x = self.y;
        self.y = tmp;
    }
};

test "automatic dereference" {
    var thing = Stuff{ .x = 10, .y = 20 };
    thing.swap();
    try expect(thing.x == 20);
    try expect(thing.y == 10);
}
