const std = @import("std");
const print = std.debug.print;

pub const Vec2 = struct {
    x: f32,
    y: f32,
};

// Add vector to current vector
pub fn add(v1: Vec2, v2: Vec2) Vec2 {
    return Vec2{ .x = (v1.x + v2.x), .y = (v1.y + v2.y) };
}

// Subtract vector from current vector
pub fn subtract(v1: Vec2, v2: Vec2) Vec2 {
    return Vec2{ .x = (v1.x - v2.x), .y = (v1.y - v2.y) };
}

// Multiplies current vector by a scalar s
pub fn scalarMultiply(v1: *Vec2, s: f32) void {
    v1.x *= s;
    v1.y *= s;
}

// Divides current vector by a scalar s
pub fn scalarDivide(v1: *Vec2, s: f32) void {
    if (s == 0) {
        print("Unable to divide by 0\n", .{});
        return;
    }

    v1.x /= s;
    v1.y /= s;
}

// Returns the dot product of current vector and v2
pub fn dot(v1: Vec2, v2: Vec2) f32 {
    return v1.x * v2.x + v1.y * v2.y;
}

// Returns the length of the current vector
pub fn length(v1: Vec2) f32 {
    return std.math.sqrt(lengthSquared(v1));
}

// Returns the length squared of the vector
pub fn lengthSquared(v1: Vec2) f32 {
    return (v1.x * v1.x) + (v1.y * v1.y);
}

// Scales current vector between [0,1] and returns it
pub fn normalize(v1: Vec2) Vec2 {
    const len: f32 = length(v1);

    if (len == 0) {
        print("Error 0 length\n", .{});
        return Vec2{ .x = 0, .y = 0 };
    }

    return Vec2{ .x = (v1.x / len), .y = (v1.y / len) };
}

// Returns the distance between the current vector and v2
pub fn distance(v1: Vec2, v2: Vec2) f32 {
    const difference = subtract(v1, v2);
    return length(difference);
}

// Returns the distance squared between the current vector and v2
pub fn distanceSquared(v1: Vec2, v2: Vec2) f32 {
    const difference = subtract(v1, v2);
    return lengthSquared(difference);
}
