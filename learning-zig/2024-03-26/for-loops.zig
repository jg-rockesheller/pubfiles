// for loops are more so used to iterate over asdf

test "for" {
    const string = [_]u8{ 'a', 'b', 'c' };

    // I'm assuming this means that we are iterating over the array `string`
    // starting at the 0 index and going to the last element
    for (string, 0..) |character, index| {
        // _ is used if we want to state that a value is unused
        _ = character;
        _ = index;
    }

    // I assume this is the same as above but we are not checking for the index
    for (string) |character| {
        _ = character;
    }

    // we can also specify that we don't care about the character
    for (string, 0..) |_, index| {
        _ = index;
    }

    // there is also support for break and continue like in while loops
}
