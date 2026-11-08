# SQL · Lesson 5: SQL COUNT, SUM, AVG Explained: COUNT(*) vs COUNT(column)

Five functions, one rule about NULL.

- **Video:** publishes Tue, Feb 16, 2027 (proposed). Link coming soon.
- **Database:** [`database/campus.sql`](../../../database/campus.sql)
- **Video script:** [SQL Lessons 3–7](../../../docs/video-scripts/sql-lessons-3-7.md)

## Prove it

Pause the video and try each problem before you look at the solution.

1. **Easy** In one query: total enrollment rows, rows with a grade, and different students enrolled.

2. **Medium** For graded enrollments: lowest, highest and average grade points, rounded to 2 places.

3. **Hard** For the Fall 2026 sections (S1, S2, S4, S5, S7, S8), predict all four values.

   ```sql
   SELECT COUNT(*) AS Enrollments,
          COUNT(GradePoints) AS Graded,
          SUM(GradePoints) AS TotalPoints,
          AVG(GradePoints) AS AvgPoints
   FROM Enrollment
   WHERE SectionID IN ('S1', 'S2', 'S4', 'S5', 'S7', 'S8');
   ```


## Check your work

- [`solution.sql`](solution.sql)

The expected output for every query is in the comments above it. Statements that are supposed to fail are commented out, so the file runs cleanly. Uncomment one to watch the database reject it.

SQLite users: the solution files turn on `PRAGMA foreign_keys = ON;`, because SQLite ignores foreign keys without it.

---

© 2026 John Conklin. Text licensed under [CC BY 4.0](https://creativecommons.org/licenses/by/4.0/). SQL code licensed under the [MIT License](../../../LICENSE).
