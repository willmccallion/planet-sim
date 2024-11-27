const pl = @import("planet.zig");
const v = @import("vector.zig");
const std = @import("std");

const G: f64 = 6.673 * std.math.pow(f64, 10, -11);

pub fn gravitationalForce(planet1: pl.Planet, planet2: pl.Planet) f64 {
    const distance_sq = v.distanceSquared(planet1.position, planet2.position);
    const force = (G * planet1.mass * planet2.mass) / distance_sq;
    return force;
}
