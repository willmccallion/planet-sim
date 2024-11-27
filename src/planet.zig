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

    pub fn printName(self: Planet) void {
        const print = std.debug.print;
        for (self.name.items) |char| {
            print("{c}", .{char});
        }
    }

    pub fn _print(self: Planet) void {
        const print = std.debug.print;

        // Print the name contents
        print("Name: ", .{});
        for (self.name.items) |char| {
            print("{c}", .{char});
        }
        print("\n", .{});

        print("Position: ({e:.2}, {e:.2})\n", .{ self.position.x, self.position.y });
        print("Velocity: ({e:.2}, {e:.2})\n", .{ self.velocity.x, self.velocity.y });
        print("Mass: {e:.2}\n\n", .{self.mass});
    }

    // Add a deinitialization method for the Planet struct
    pub fn deinit(self: *Planet) void {
        self.name.deinit(); // Deinitialize the name ArrayList
    }
};

pub fn initSolarSystem() ![10]Planet {
    const allocator = std.heap.page_allocator;
    var planets: [10]Planet = undefined;

    const planetData = [_][]const u8{ "Sun", "Mercury", "Venus", "Earth", "Mars", "Jupiter", "Saturn", "Uranus", "Neptune", "Pluto" };

    const velocities = [_]v.Vec2{ v.Vec2{ .x = 0, .y = 0 }, v.Vec2{ .x = 47.4, .y = 0 }, v.Vec2{ .x = 35.0, .y = 0 }, v.Vec2{ .x = 29.8, .y = 0 }, v.Vec2{ .x = 24.1, .y = 0 }, v.Vec2{ .x = 13.1, .y = 0 }, v.Vec2{ .x = 9.7, .y = 0 }, v.Vec2{ .x = 6.8, .y = 0 }, v.Vec2{ .x = 5.4, .y = 0 }, v.Vec2{ .x = 4.7, .y = 0 } };
    const positions = [_]v.Vec2{
        v.Vec2{ .x = 0, .y = 0 },
        v.Vec2{ .x = 5.791e8, .y = 0 }, // Mercury
        v.Vec2{ .x = 1.082e8, .y = 0 }, // Venus
        v.Vec2{ .x = 1.496e11, .y = 0 }, // Earth
        v.Vec2{ .x = 2.279e8, .y = 0 }, // Mars
        v.Vec2{ .x = 7.785e8, .y = 0 }, // Jupiter
        v.Vec2{ .x = 1.434e9, .y = 0 }, // Saturn
        v.Vec2{ .x = 2.871e9, .y = 0 }, // Uranus
        v.Vec2{ .x = 4.495e9, .y = 0 }, // Neptune
        v.Vec2{ .x = 5.906e9, .y = 0 }, // Pluto
    };

    const masses = [_]f64{ 1.989e30, 3.3011e23, 4.8675e24, 5.97219e24, 6.4171e23, 1.8982e27, 5.6834e26, 8.6810e25, 1.02413e26, 1.303e22 };

    for (0..10) |i| {
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
