const std = @import("std");
const pl = @import("planet.zig");
const phy = @import("physics.zig");

const print = std.debug.print;

pub fn main() !void {
    const planets = try pl.initSolarSystem();
    print("Mass: {e:.2}\n", .{planets[4].mass});
}
