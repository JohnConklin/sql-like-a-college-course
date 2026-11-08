# Database Design · Lesson 5: 7 Database Design Mistakes I See in Student Projects

Each one shown, fixed and proven in SQL.

- **Video:** publishes Tue, Dec 8, 2026. Link coming soon.
- **Database:** each solution file builds its own small tables. Run it in a new, empty database.

## Prove it

Pause the video and try each problem before you look at the solution.

This lesson walks through seven mistakes. For each one, say what breaks and how you would fix it before the video shows the answer.

1. A name as the primary key.
2. A list in one cell.
3. Numbered columns.
4. The foreign key on the wrong side.
5. Many-to-many with no junction table.
6. Storing a total you can calculate.
7. The wrong data type.

## Check your work

- [`solution.sql`](solution.sql)

The expected output for every query is in the comments above it. Statements that are supposed to fail are commented out, so the file runs cleanly. Uncomment one to watch the database reject it.

SQLite users: the solution files turn on `PRAGMA foreign_keys = ON;`, because SQLite ignores foreign keys without it.

---

© 2026 John Conklin. Text licensed under [CC BY 4.0](https://creativecommons.org/licenses/by/4.0/). SQL code licensed under the [MIT License](../../../LICENSE).
