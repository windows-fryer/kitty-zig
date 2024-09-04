const std = @import("std");

const Processor = @import("processor.zig");
const Machine = @This();

pub const MachineError = error{
    HandleCollision,
    HandleNotFound,
};

allocator: std.mem.Allocator,
processors: std.AutoHashMap(usize, Processor),

pub fn init(allocator: std.mem.Allocator) !*Machine {
    const machine: *Machine = try allocator.create(Machine);

    machine.* = .{
        .allocator = allocator,
        .processors = std.AutoHashMap(usize, Processor).init(allocator),
    };

    return machine;
}

pub fn deinit(self: *Machine) void {
    self.processors.deinit();
    self.allocator.destroy(self);
}

pub fn create_processor(self: *Machine) !usize {
    const handle = std.crypto.random.int(usize);
    const result = try self.processors.getOrPut(handle);

    if (result.found_existing)
        return try create_processor(self);

    result.value_ptr.* = Processor.init();

    return handle;
}

pub fn destroy_processor(self: *Machine, handle: usize) !void {
    if (!self.processors.remove(handle))
        return MachineError.HandleNotFound;
}

pub fn get_processor(self: *Machine, handle: usize) ?*Processor {
    return self.processors.getPtr(handle);
}
