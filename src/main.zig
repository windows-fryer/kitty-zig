const std = @import("std");
const kitty = @import("modules/kitty.zig");

pub fn main() !void {
    const vm = try kitty.vm.Machine.init(std.heap.page_allocator);

    const handle = try vm.create_processor();
    const processor = vm.get_processor(handle) orelse unreachable;

    processor.registers[0].data = 1;

    vm.deinit();
}
