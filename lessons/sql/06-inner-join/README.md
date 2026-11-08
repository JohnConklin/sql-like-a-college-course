# SQL · Lesson 6: SQL INNER JOIN Explained Step by Step (With Exam Problems)

Match rows across tables, then prove the row count.

- **Video:** publishes Tue, Feb 23, 2027 (proposed). Link coming soon.
- **Database:** [`database/campus.sql`](../../../database/campus.sql)
- **Video script:** [SQL Lessons 3–7](../../../docs/video-scripts/sql-lessons-3-7.md)

## Prove it

Pause the video and try each problem before you look at the solution.

1. **Easy** List every Information Systems major and the sections they're enrolled in. Show StudentID, Name and SectionID, sorted by StudentID, then SectionID. How many rows?

2. **Medium** List Dr. Kim's sections with each course title and credits.

3. **Hard** List every section with its instructor's name. Section has 8 rows. Why does this return 7?

   ```sql
   SELECT s.SectionID, s.CourseID, i.Name
   FROM Section AS s
   JOIN Instructor AS i
     ON i.InstructorID = s.InstructorID
   ORDER BY s.SectionID;
   ```


## Check your work

- [`solution.sql`](solution.sql)

The expected output for every query is in the comments above it. Statements that are supposed to fail are commented out, so the file runs cleanly. Uncomment one to watch the database reject it.

SQLite users: the solution files turn on `PRAGMA foreign_keys = ON;`, because SQLite ignores foreign keys without it.

---

© 2026 John Conklin. Text licensed under [CC BY 4.0](https://creativecommons.org/licenses/by/4.0/). SQL code licensed under the [MIT License](../../../LICENSE).
