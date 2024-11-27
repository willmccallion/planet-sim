const std = @import("std");
const v = @import("vector.zig");

pub const Planet = struct {
    name: std.ArrayList(u8),
    velocity: v.Vec2,
    position: v.Vec2,
    mass: f64,

    pub fn set_name(self: *Planet, name: []const u8) !void {
        try self.name.appendSlice(name);
    }

    pub fn next_pos(self: *Planet) void {
        self.position = v.add(self.position, self.velocity);
    }

    pub fn _print(self: *Planet) void {
        const print = std.debug.print;

        // Print the name contents
        print("Name: ", .{});
        for (self.name.items) |char| {
            print("{c}", .{char});
        }
        print("\n", .{});

        print("Position: ({d}, {d})\n", .{ self.position.x, self.position.y });
        print("Velocity: ({d}, {d})\n", .{ self.velocity.x, self.velocity.y });
        print("Mass: {e:.2}\n\n", .{self.mass});
    }

    // Add a deinitialization method for the Planet struct
    pub fn deinit(self: *Planet) void {
        self.name.deinit(); // Deinitialize the name ArrayList
    }
};

pub fn initSolarSystem() ![9]Planet {
    const allocator = std.heap.page_allocator;
    var planets: [9]Planet = undefined;

    const planetData = [_][]const u8{ "Mercury", "Venus", "Earth", "Mars", "Jupiter", "Saturn", "Uranus", "Neptune", "Pluto" };

    const velocities = [_]v.Vec2{ v.Vec2{ .x = 47.4, .y = 0 }, v.Vec2{ .x = 35.0, .y = 0 }, v.Vec2{ .x = 29.8, .y = 0 }, v.Vec2{ .x = 24.1, .y = 0 }, v.Vec2{ .x = 13.1, .y = 0 }, v.Vec2{ .x = 9.7, .y = 0 }, v.Vec2{ .x = 6.8, .y = 0 }, v.Vec2{ .x = 5.4, .y = 0 }, v.Vec2{ .x = 4.7, .y = 0 } };

    const positions = [_]v.Vec2{ v.Vec2{ .x = 57.9e6, .y = 0 }, v.Vec2{ .x = 108.2e6, .y = 0 }, v.Vec2{ .x = 149.6e6, .y = 0 }, v.Vec2{ .x = 227.9e6, .y = 0 }, v.Vec2{ .x = 778.5e6, .y = 0 }, v.Vec2{ .x = 1.434e9, .y = 0 }, v.Vec2{ .x = 2.871e9, .y = 0 }, v.Vec2{ .x = 4.495e9, .y = 0 }, v.Vec2{ .x = 5.906e9, .y = 0 } };

    const masses = [_]f64{ 3.3011e23, 4.8675e24, 5.97219e24, 6.4171e23, 1.8982e27, 5.6834e26, 8.6810e25, 1.02413e26, 1.303e22 };

    for (0..9) |i| {
        planets[i] = Planet{
            .name = std.ArrayList(u8).init(allocator),
            .velocity = velocities[i],
            .position = positions[i],
            .mass = masses[i],
        };
        try planets[i].set_name(planetData[i]);
    }

    return planets;
}
