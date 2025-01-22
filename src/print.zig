const std = @import("std");
const allocator = std.heap.c_allocator;

export fn day_zig_3(so_far: [*c]u8) callconv(.C) [*c]const u8 {
    const today: []const u8 = "Three new C's\n";
    const out: []const u8 = std.fmt.allocPrint(allocator, "{s}{s}", .{ so_far, today }) catch "FAILURE";
    const s = std.mem.span(so_far);
    allocator.free(s);
    return out.ptr;
}
