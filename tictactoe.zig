const std = @import("std");

const gamestatus = enum { running, win1, win2, draw };

fn drawBoard(board: [3][3]u8) void {
    std.debug.print("{any}", .{board});
}

fn getPlayerInput() !u8 {}

fn makeChoice() !void {}

fn checkWin() gamestatus {
    return gamestatus.draw;
}

pub fn main() void {
    var status: gamestatus = .running;
    var turn: bool = true;
    const board: [3][3]u8 = .{
        .{ '1', '2', '3' },
        .{ '4', '5', '6' },
        .{ '7', '8', '9' },
    };

    //game loop
    while (status == .running) {
        drawBoard(board);

        if (turn) {
            std.debug.print("Player's Turn", .{});
        }
        turn = !turn;
        status = checkWin();
    }
    std.debug.print("hello {s}", .{"world"});
}
