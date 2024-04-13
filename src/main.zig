const std = @import("std");
const sqlite = @import("sqlite");

pub fn main() !void {
    std.debug.print("Hello world", .{});

    var db = try sqlite.Db.init(.{
        .mode = sqlite.Db.Mode{ .File = "./db.sqlite" },
        .open_flags = .{
            .write = true,
            .create = true,
        },
        .threading_mode = .MultiThread,
    });

    const schema =
        \\ CREATE TABLE Persons (
        \\ PersonID int,
        \\ FirstName varchar(255),
        \\ LastName varchar(255)
        \\ );
    ;

    //     const query =
    //     \\ INSERT INTO Persons (PersonID, FirstName, LastName) VALUES (?, ?, ?);
    // ;

    var stmt = try db.prepare(schema);
    defer stmt.deinit();

    try stmt.exec(.{}, .{});

    std.debug.print("finished", .{});
}
