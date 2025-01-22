const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const libprint_zig = b.addStaticLibrary(.{
        .name = "print_zig",
        .root_source_file = b.path("src/print.zig"),
        .target = target,
        .optimize = optimize,
    });

    b.installArtifact(libprint_zig);
}
