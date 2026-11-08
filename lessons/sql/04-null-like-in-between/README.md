# SQL · Lesson 4: SQL NULL, LIKE, IN and BETWEEN: Why "= NULL" Returns Nothing

Four filters every exam tests, and the one that lies.

- **Video:** publishes Tue, Feb 9, 2027 (proposed). Link coming soon.
- **Database:** [`database/campus.sql`](../../../database/campus.sql)
- **Video script:** [SQL Lessons 3–7](../../../docs/video-scripts/sql-lessons-3-7.md)

## Prove it

Pause the video and try each problem before you look at the solution.

1. **Easy** a. Students majoring in Mathematics or Data Analytics, using IN. b. Students with IDs from 10022 to 10025. How many rows?

2. **Medium** Find every student whose name has 'a' as the second letter.

3. **Hard** a. How many enrollments are still in progress? b. How many enrollments are not an A?

   ```sql
   SELECT COUNT(*) AS InProgress
   FROM Enrollment
   WHERE Grade = NULL;
   ```

   ```sql
   SELECT COUNT(*) AS NotA
   FROM Enrollment
   WHERE Grade <> 'A';
   ```


## Check your work

- [`solution.sql`](solution.sql)

The expected output for every query is in the comments above it. Statements that are supposed to fail are commented out, so the file runs cleanly. Uncomment one to watch the database reject it.

SQLite users: the solution files turn on `PRAGMA foreign_keys = ON;`, because SQLite ignores foreign keys without it.

---

© 2026 John Conklin. Text licensed under [CC BY 4.0](https://creativecommons.org/licenses/by/4.0/). SQL code licensed under the [MIT License](../../../LICENSE).
