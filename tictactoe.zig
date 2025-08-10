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

fn getPlayerInput() !u8 {
    var buffer: [5]u8 = undefined;
    const stdin = std.io.getStdIn().reader();
    const input = try stdin.readUntilDelimiter(&buffer, '\n');
    return input[0];
}

fn makeChoice(board: *[3][3]u8, choice: u8, turn: bool) !void {
    if (choice < '1' or choice > '9') {
        return error.InvalidMove;
    }
    const pos = choice - '1';
    const row = pos / 3;
    const col = pos % 3;

    if (board[row][col] != 'X' and board[row][col] != 'O') {
        if (turn) {
            board[row][col] = 'X';
        } else board[row][col] = 'O';
    } else {
        std.debug.print("Invalid move!\n", .{});
        return error.InvalidMove;
    }
}

fn checkWin(board: [3][3]u8) gamestatus {
    for (0..3) |i| {
        if (board[i][0] == board[i][1] and board[i][1] == board[i][2]) {
            if (board[i][0] == 'X') return .win1;
            if (board[i][0] == 'O') return .win2;
        }
        if (board[0][i] == board[1][i] and board[1][i] == board[2][i]) {
            if (board[0][i] == 'X') return .win1;
            if (board[0][i] == 'O') return .win2;
        }
    }

    if (board[0][0] == board[1][1] and board[1][1] == board[2][2]) {
        if (board[0][0] == 'X') return .win1;
        if (board[0][0] == 'O') return .win2;
    }
    if (board[0][2] == board[1][1] and board[1][1] == board[2][0]) {
        if (board[0][2] == 'X') return .win1;
        if (board[0][2] == 'O') return .win2;
    }

    for (board) |row| {
        for (row) |cell| {
            if (cell != 'X' and cell != 'O') return .running;
        }
    }

    return .draw;
}

pub fn main() !void {
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
            std.debug.print("1st player turn : ", .{});
        } else {
            std.debug.print("2nd player turn : ", .{});
        }
        const choice = try getPlayerInput();
        try makeChoice(&board, choice, turn);
        turn = !turn;
        status = checkWin(board);
        switch (status) {
            .win1 => {
                std.debug.print("Player 1 wins!\n", .{});
                drawBoard(&board);
            },
            .win2 => {
                std.debug.print("Player 2 wins!\n", .{});
                drawBoard(&board);
            },
            .draw => {
                std.debug.print("draw!\n", .{});
                drawBoard(&board);
            },
            else => {
                continue;
            },
        }
    }
}
