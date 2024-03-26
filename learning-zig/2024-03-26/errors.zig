const expect = @import("std").testing.expect;
//
// an error set in Zig is like an enum, where each error is a value
const FileOpenError = error{
    AccessDenied,
    OutOfMemory,
    FileNotFound,
};

// error sets coerce to their supersets
// here, `AllocationError` is a subset of `FileOpenError`
const AllocationError = error{OutOfMemory};

test "coerce error from a subset to a superset" {
    const err: FileOpenError = AllocationError.OutOfMemory;
    try expect(err == FileOpenError.OutOfMemory);
}

test "error union" {
    // an error union is when a value can either be an actual value, or an
    // error value, denoted with a `!` after the error and before the type
    const maybe_error: AllocationError!u16 = 10;
    // if `maybe_error` evaluated to an error, `no_error` would have evaluated
    // to `0`
    const no_error = maybe_error catch 0;

    // `catch` is used to unwrap errors
    // reminds me of functors in Haskell, especially `either`

    try expect(@TypeOf(no_error) == u16);
    try expect(no_error == 10);
}

// functions often return error unions
fn failingFunction() error{Oops}!void {
    return error.Oops;
}

test "returning an error" {
    // when calling a function, we can use catch |err| to capture the error
    // and then do stuff with it in an expression
    failingFunction() catch |err| {
        try expect(err == error.Oops);
        return;
    };
}

// `try x` is a shortcut for `x catch |err| return err`
fn failFn() error{Oops}!i32 {
    // this will propagate the error from the `failingFunction()` call
    try failingFunction();
    return 12;
}

test "try" {
    var v = failFn() catch |err| {
        try expect(err == error.Oops);
        return;
    };

    try expect(v == 12); // this will always fail
}

// `errdefer` is like `defer`, but it will evaluate only if an error is
// returned from the block

var problems: u32 = 98;

fn failFnCounter() error{Oops}!void {
    errdefer problems += 1;
    try failingFunction(); // this will propagate an error
    // because this function will return a value, the errdefer expression will
    // be evaluated
}

test "errdefer" {
    failFnCounter() catch |err| {
        try expect(err == error.Oops);
        try expect(problems == 99);
        return;
    };
}

// you do not have to define the error set a function's returned error union
// will be a part of

// this can return any possible error that a function can return
fn createFile() !void {
    return error.AccessDenied;
}

test "inferred error set" {
    const x: error{AccessDenied}!void = createFile();

    // we can't just say `_ = x` because it is an error union
    _ = x catch {};
}
