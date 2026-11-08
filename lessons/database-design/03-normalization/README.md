# Database Design · Lesson 3: Database Normalization Explained: 1NF to 3NF With One Messy Table

One table, three steps, and a SQL proof.

- **Video:** publishes Tue, Nov 24, 2026. Link coming soon.
- **Database:** each solution file builds its own small tables. Run it in a new, empty database.

## Prove it

Pause the video and try each problem before you look at the solution.

**The messy table:**

| StudentID | StudentName | Courses |
|---|---|---|
| 10021 | Ana Garcia | CS101 Intro to Programming / I1 / ENG 210 / A; IS200 Web Development / I3 / BUS 118 / B |
| 10022 | Jordan Lee | CS101 Intro to Programming / I1 / ENG 210 / B; CS250 Database Systems / I2 / ENG 305 / A |
| 10024 | Maya Patel | CS250 Database Systems / I2 / ENG 305 / C |

**Business rules:**
- Each course has one instructor this term.
- Each instructor has one office.
- A student gets one grade per course.

1. **Easy** Put this table in 1NF. What's the primary key?

2. **Medium** List the functional dependencies. Which depend on only part of the key? Get to 2NF.

3. **Hard** Course(CourseID, Title, InstructorID, Office) is in 2NF. Is it in 3NF? If not, fix it.


## Check your work

- [`solution.sql`](solution.sql)

The expected output for every query is in the comments above it. Statements that are supposed to fail are commented out, so the file runs cleanly. Uncomment one to watch the database reject it.

SQLite users: the solution files turn on `PRAGMA foreign_keys = ON;`, because SQLite ignores foreign keys without it.

---

© 2026 John Conklin. Text licensed under [CC BY 4.0](https://creativecommons.org/licenses/by/4.0/). SQL code licensed under the [MIT License](../../../LICENSE).
