const std = @import("std");
const builtin = @import("builtin");

const Move = @This();
const Template = @import("template.zig");
const Register = @import("../register.zig");
const Processor = @import("../processor.zig");
const Instruction = @import("../instructions.zig");

usingnamespace Template;

fn run_impl(processor: *Processor, data: []const u8) usize {
    const opcode = data[0];
    const opcodeFlags = @as(u4, @truncate(opcode >> 4));
    const registerData = Template.handle_register(processor, data[1]);

    std.debug.print("{b}", .{opcodeFlags});

    if (opcodeFlags & @intFromEnum(Template.InstructionOperandMode.Operand1Numeric) != 0)
        @panic("Operand1Numeric not implemented");

    if (opcodeFlags & @intFromEnum(Template.InstructionOperandMode.Operand2Numeric) != 0) {
        registerData.register.assign(registerData.mode, std.mem.readInt(u64, data[2..10], builtin.cpu.arch.endian()));

        return @sizeOf(u64) + @sizeOf(u8) + @sizeOf(u8);
    }

    const registerDataOther = Template.handle_register(processor, data[2]);

    registerData.register.assign_register(registerData.mode, registerDataOther.register, registerDataOther.mode);

    return @sizeOf(u8) + @sizeOf(u8) + @sizeOf(u8);
}

vtable: Template.VTable = .{
    .run = run_impl,
}
