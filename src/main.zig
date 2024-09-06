const std = @import("std");
const kitty = @import("modules/kitty.zig");

pub fn main() !void {
    const vm = try kitty.vm.create(std.heap.page_allocator);
    defer vm.destroy();

    // Lets get coding.
}
