// opaque types in zig have an unknown, non-zero size and alignment
// used to maintain type safety with pointers to types that we don't have
// information about

const Window = opaque {};
const Button = opaque {};

// we don't have information about what this function takes in, which is why we
// make an opaque type
extern fn show_window(*Window) callconv(.C) void;

test "opaque" {
    var main_window: *Window = undefined;
    show_window(main_window);

    // this will result in an error
    // var ok_button: *Button = undefined;
    // show_window(ok_button);
}

// opaque types also have methods
const Window2 = opaque {
    fn show(self: *Window2) void {
        show_window2(self);
    }
};

extern fn show_window2(*Window2) callconv(.C) void;

test "opaque with declarations" {
    var main_window: *Window2 = undefined;
    main_window.show();
}

// opaque is mainly used to maintain type safety when interoperating with C
// code that does not expose complete type information
