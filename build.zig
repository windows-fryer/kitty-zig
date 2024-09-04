const std = @import("std");

pub fn build(builder: *std.Build) !void {
    const target = builder.standardTargetOptions(.{});
    const optimization = builder.standardOptimizeOption(.{});

    // Create an iterator for the source directory and create a static library for each module

    var absoluteSourceDirectory = try std.fs.openDirAbsolute(builder.pathFromRoot("src/modules/"), .{ .iterate = true });
    var sourceDirectoryIterator = absoluteSourceDirectory.iterate();

    while (try sourceDirectoryIterator.next()) |entry| {
        if (entry.kind != .directory)
            continue;

        const moduleRootFile = try std.mem.concat(builder.allocator, u8, &[_][]const u8{ "src/modules/", entry.name, "/root.zig" });

        const buildArtifact = builder.addStaticLibrary(.{
            .name = entry.name,
            .target = target,
            .optimize = optimization,
            .root_source_file = builder.path(moduleRootFile),
        });

        builder.installArtifact(buildArtifact);

        builder.allocator.free(moduleRootFile);
    }

    absoluteSourceDirectory.close();

    // Create the main executable, used mainly for testing

    const buildArtifact = builder.addExecutable(.{
        .name = "main",
        .target = target,
        .optimize = optimization,
        .root_source_file = builder.path("src/main.zig"),
    });

    builder.installArtifact(buildArtifact);

    // Create a run command for the main executable

    const runOption = builder.step("run", "Run the main executable");
    const runCommand = builder.addRunArtifact(buildArtifact);

    runOption.dependOn(&runCommand.step);
}
