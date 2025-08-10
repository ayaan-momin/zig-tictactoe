const std = @import("std");

const gamestatus = enum { running, win1, win2, draw };

fn drawBoard() void {}

fn getPlayerInput() !u8 {}

fn makeChoice() !void {}

fn checkWin() gamestatus {}

pub fn main() void {
    std.debug.print("hello {s}", .{"world"});
}
