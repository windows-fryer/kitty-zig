const Move = @This();
const Template = @import("template.zig");

usingnamespace Template;

fn run_impl(data: []const u8) usize {
    return data.ptr;
}

vtable: Template.VTable = .{
    .run = run_impl,
}
