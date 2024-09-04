const std = @import("std");

const Processor = @This();
const Register = @import("register.zig");

registers: [16]Register,
binary: []const u8,

pub fn init() Processor {
    const processor: Processor = .{
        .registers = std.mem.zeroes([16]Register),
        .binary = undefined,
    };

    return processor;
}
