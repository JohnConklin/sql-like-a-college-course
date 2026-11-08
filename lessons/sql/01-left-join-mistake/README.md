# SQL · Lesson 1: The SQL JOIN Mistake That Costs Students Points

LEFT JOIN, NULLs, and the WHERE clause that breaks them.

- **Video:** publishes Tue, Dec 29, 2026. Link coming soon.
- **Database:** [`database/campus.sql`](../../../database/campus.sql)

## Prove it

Pause the video and try each problem before you look at the solution.

1. **Easy** Find the students who aren't enrolled in any section.

2. **Medium** List every instructor with their Fall 2026 sections. Instructors with no Fall 2026 section must still appear.

3. **Hard** Count each instructor's Fall 2026 sections. Show 0 for anyone with none.


## Check your work

- [`solution.sql`](solution.sql)

The expected output for every query is in the comments above it. Statements that are supposed to fail are commented out, so the file runs cleanly. Uncomment one to watch the database reject it.

SQLite users: the solution files turn on `PRAGMA foreign_keys = ON;`, because SQLite ignores foreign keys without it.

---

© 2026 John Conklin. Text licensed under [CC BY 4.0](https://creativecommons.org/licenses/by/4.0/). SQL code licensed under the [MIT License](../../../LICENSE).
