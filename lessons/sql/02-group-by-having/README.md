# SQL · Lesson 2: GROUP BY vs HAVING: 3 Exam Problems Solved

- **Video:** publishes Tue, Jan 5, 2027. Link coming soon.
- **Database:** [`database/campus.sql`](../../../database/campus.sql)

## Prove it

Pause the video and try each problem before you look at the solution.

1. **Easy** Show each course's CourseID, Title and total enrollments across all terms and sections, highest first.

2. **Medium** Which courses have more than 3 enrollments in Fall 2026? Show the count.

3. **Hard** List every student taking 2 or more sections in Fall 2026, with the count.


## Check your work

- [`solution.sql`](solution.sql)

The expected output for every query is in the comments above it. Statements that are supposed to fail are commented out, so the file runs cleanly. Uncomment one to watch the database reject it.

SQLite users: the solution files turn on `PRAGMA foreign_keys = ON;`, because SQLite ignores foreign keys without it.

---

© 2026 John Conklin. Text licensed under [CC BY 4.0](https://creativecommons.org/licenses/by/4.0/). SQL code licensed under the [MIT License](../../../LICENSE).
