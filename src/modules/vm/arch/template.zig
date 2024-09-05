const std = @import("std");

const Template = @This();
const Processor = @import("../processor.zig");
const Register = @import("../register.zig");

pub const InstructionOperandMode = enum(u4) {
    Operand1Numeric = 0b0010,
    Operand2Numeric = 0b0001,
};

pub const VTable = struct {
    run: *const fn (processor: *Processor, data: []const u8) usize,
};

vtable: *const VTable,

const RegisterValue = struct {
    mode: Register.RegisterMode,
    register: *Register,
};

pub fn handle_register(self: *Processor, opcode: u8) RegisterValue {
    const register_mode = opcode << 1 >> 5; // 0b1001_1111 -> 0b0011_1110 -> 0b0000_1000
    const register_index = opcode << 4 >> 4; // 0b1001_1111 -> 01111_0000 -> 0000_1111

    std.debug.print("register_mode: {b}", .{register_mode});

    return .{
        .mode = @as(Register.RegisterMode, @enumFromInt(register_mode)),
        .register = &self.registers[register_index],
    };
}

pub fn run(self: Template, processor: *Processor, data: []const u8) usize {
    return self.vtable.run(processor, data);
}
