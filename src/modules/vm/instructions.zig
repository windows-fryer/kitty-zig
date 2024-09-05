const Template = @import("arch/template.zig");

pub const List = enum(u4) {
    Move = 0b0000,

    pub fn vtable(opcode: u8) Template.VTable {
        const truncated = @as(u4, @truncate(opcode));

        switch (truncated) {
            @intFromEnum(List.Move) => return (@import("arch/move.zig"){}).vtable,

            else => unreachable,
        }
    }
};
