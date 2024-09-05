const std = @import("std");

const Processor = @This();
const Register = @import("register.zig");
const Instructions = @import("instructions.zig");
const Template = @import("arch/template.zig");

registers: [16]Register,
binary: []const u8,

pub fn init() Processor {
    const processor: Processor = .{
        .registers = std.mem.zeroes([16]Register),
        .binary = undefined,
    };

    return processor;
}

pub fn load_binary(self: *Processor, slice: []const u8) void {
    std.mem.copyForwards(u8, self.binary, slice);
}

fn handle_extended(self: *Processor, binary: []const u8) usize {
    _ = self;
    _ = binary;

    unreachable;
}

fn handle_non_extended(self: *Processor, binary: []const u8) usize {
    const instruction = Instructions.List.vtable(binary[0]);

    return instruction.run(self, binary);
}

pub fn execute(self: *Processor) void {
    var index: usize = 0;

    while (index < self.binary.len) {
        const opcode = self.binary[index];

        if (opcode & 0b0100_0000 != 0) {
            index += self.handle_extended(self.binary[index..]);
        } else {
            index += self.handle_non_extended(self.binary[index..]);
        }
    }
}
