const Register = @This();

pub const RegisterMode = enum(u4) {
    Data8 = 0b000,
    Data16 = 0b001,
    Data32 = 0b010,
    Data64 = 0b100,
};

data: u64,

pub fn as(self: Register, comptime T: type) T {
    // if (!@inComptime())
    //     @compileError("Register.as() can only be used at compile-time");

    return @as(T, @truncate(self.data));
}

pub fn as_ptr(self: Register, comptime T: type) *T {
    // if (!@inComptime())
    //     @compileError("Register.as() can only be used at compile-time");

    return @constCast(&@as(T, @truncate(self.data)));
}

pub fn from_mode(self: Register, mode: RegisterMode) u64 {
    switch (mode) {
        RegisterMode.Data8 => return self.as(u8),
        RegisterMode.Data16 => return self.as(u16),
        RegisterMode.Data32 => return self.as(u32),
        RegisterMode.Data64 => return self.as(u64),
    }

    unreachable;
}

pub fn assign(self: Register, mode: RegisterMode, value: u64) void {
    switch (mode) {
        RegisterMode.Data8 => self.as_ptr(u8).* = @truncate(value),
        RegisterMode.Data16 => self.as_ptr(u16).* = @truncate(value),
        RegisterMode.Data32 => self.as_ptr(u32).* = @truncate(value),
        RegisterMode.Data64 => self.as_ptr(u64).* = @truncate(value),
    }

    unreachable;
}

pub fn assign_register(self: *Register, self_mode: RegisterMode, other: *Register, other_mode: RegisterMode) void {
    const value: u64 = other.from_mode(other_mode);

    self.assign(self_mode, value);
}
