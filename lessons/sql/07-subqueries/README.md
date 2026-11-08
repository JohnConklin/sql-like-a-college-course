# SQL · Lesson 7: SQL Subqueries Explained: IN, NOT IN and the NULL Trap

A question inside a question.

- **Video:** publishes Tue, Mar 2, 2027 (proposed). Link coming soon.
- **Database:** [`database/campus.sql`](../../../database/campus.sql)
- **Video script:** [SQL Lessons 3–7](../../../docs/video-scripts/sql-lessons-3-7.md)

## Prove it

Pause the video and try each problem before you look at the solution.

1. **Easy** Find every enrollment with grade points above the average.

2. **Medium** List every student enrolled in any section taught by Dr. Ortiz (I3). Each student once.

3. **Hard** Find the instructors who mentor no one. Predict the result.

   ```sql
   SELECT Name
   FROM Instructor
   WHERE InstructorID NOT IN (SELECT MentorID FROM Instructor);
   ```


## Check your work

- [`solution.sql`](solution.sql)

The expected output for every query is in the comments above it. Statements that are supposed to fail are commented out, so the file runs cleanly. Uncomment one to watch the database reject it.

SQLite users: the solution files turn on `PRAGMA foreign_keys = ON;`, because SQLite ignores foreign keys without it.

---

© 2026 John Conklin. Text licensed under [CC BY 4.0](https://creativecommons.org/licenses/by/4.0/). SQL code licensed under the [MIT License](../../../LICENSE).
