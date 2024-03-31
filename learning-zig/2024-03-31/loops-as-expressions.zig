const expect = @import("std").testing.expect;

fn rangeHasNumber(begin: usize, end: usize, number: usize) bool {
    var i = begin;
    // you can return loops because they are expressions
    return while (i < end) : (i += 1) {
        if (i == number) break true;
    } else false;
}

test "while loop expressions" {
    try expect(rangeHasNumber(0, 10, 3));
}
