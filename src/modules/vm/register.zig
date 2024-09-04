const Register = @This();

data: u64,

pub fn as(self: Register, comptime T: type) T {
    if (!@inComptime())
        @compileError("Register.as() can only be used at compile-time");

    if (@bitSizeOf(T) < @bitSizeOf(self.data))
        return @as(T, @truncate(self.data));

    return @as(T, self.data);
}
