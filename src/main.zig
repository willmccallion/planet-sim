const std = @import("std");
const pl = @import("planet.zig");
const phy = @import("physics.zig");

const print = std.debug.print;

pub fn main() !void {
    const planets = try pl.initSolarSystem();
    for (0..10) |i| {
        planets[i]._print();
    }

    for (0..10) |i| {
        for (0..10) |j| {
            if (i == j) {
                continue;
            }
            print("Force between ", .{});
            planets[i].printName();
            print(" and ", .{});
            planets[j].printName();
            print("\nForce: {e:.2}\n", .{phy.gravitationalForce(planets[i], planets[j])});
        }
        print("\n", .{});
    }
    print("Force earth-mars: {e:.2}\n", .{phy.gravitationalForce(planets[0], planets[3])});
}
