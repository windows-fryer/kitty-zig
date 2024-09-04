const Template = @This();

pub const VTable = struct {
    run: *const fn (data: []const u8) usize,
};

vtable: VTable,

run: @TypeOf(VTable.run),
