const std = @import("std");

const VirtualMachine = @This();

allocator: std.mem.Allocator,

pub fn create(allocator: std.mem.Allocator) !*VirtualMachine {
    const self = try allocator.create(VirtualMachine);

    self.allocator = allocator;

    return self;
}

pub fn destroy(self: *VirtualMachine) void {
    // I don't feel safe freeing self while using its vtable.
    const allocator = self.allocator;

    allocator.destroy(self);
}
