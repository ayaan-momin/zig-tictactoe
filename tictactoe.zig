const std = @import("std");

const gamestatus = enum { running, win1, win2, draw };

fn drawBoard(board: *[3][3]u8) void {
    for (board) |row| {
        for (row, 0..3) |eliment, index| {
            std.debug.print("{c}", .{eliment});
            if (index != 2) std.debug.print("| ", .{});
        }
        std.debug.print("\n", .{});
    }
}

fn getPlayerInput() !u8 {}

fn makeChoice() !void {}

fn checkWin() gamestatus {
    return gamestatus.draw;
}

pub fn main() void {
    var status: gamestatus = .running;
    var turn: bool = true;
    var board: [3][3]u8 = .{
        .{ '1', '2', '3' },
        .{ '4', '5', '6' },
        .{ '7', '8', '9' },
    };

    //game loop
    while (status == .running) {
        drawBoard(&board);

        if (turn) {
            std.debug.print("1st player turn", .{});
        } else {
            std.debug.print("2nd player turn", .{});
        }
        turn = !turn;
        status = checkWin();
    }
    std.debug.print("hello {s}", .{"world"});
}
