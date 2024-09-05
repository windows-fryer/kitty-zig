const std = @import("std");
const kitty = @import("modules/kitty.zig");

pub fn main() !void {
    const vm = try kitty.vm.Machine.init(std.heap.page_allocator);

    const handle = try vm.create_processor();
    const processor = vm.get_processor(handle) orelse unreachable;

    processor.binary = &([_]u8{
        0b0001_0000,

        0b00000000,
        0b00000000,
        0b00000000,
        0b00010000,
        0b00000000,
        0b00000000,
        0b00000000,
        0b00000000,

        0b1000_0000,
    });

    processor.execute();

    std.debug.print("Register Layout: {any}", .{
        processor.registers,
    });

    vm.deinit();
}
