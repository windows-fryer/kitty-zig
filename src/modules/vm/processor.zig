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

pub fn execute(self: *Processor) void {
    for (0..self.binary.len) |i| {
        const opcode = self.binary[i];
        const instruction: Template = @as(@enumFromInt(opcode), Instructions.List);

        instruction.run(self.binary);
    }
}
