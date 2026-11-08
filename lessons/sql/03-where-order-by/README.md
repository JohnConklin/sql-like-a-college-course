# SQL · Lesson 3: SQL WHERE and ORDER BY: The AND/OR Mistake That Costs Exam Points

Filter rows, sort results, and read AND/OR the way SQL does.

- **Video:** publishes Tue, Feb 2, 2027 (proposed). Link coming soon.
- **Database:** [`database/campus.sql`](../../../database/campus.sql)
- **Video script:** [SQL Lessons 3–7](../../../docs/video-scripts/sql-lessons-3-7.md)

## Prove it

Pause the video and try each problem before you look at the solution.

1. **Easy** List every Computer Science major's ID and name, sorted by name.

2. **Medium** List every course, highest credits first. Break ties alphabetically by title.

3. **Hard** List the Fall 2026 sections taught by I2 (Dr. Kim) or I3 (Dr. Ortiz). This returns 5 rows. Find the bug.

   ```sql
   SELECT SectionID, Term, InstructorID
   FROM Section
   WHERE Term = 'Fall 2026'
     AND InstructorID = 'I2'
      OR InstructorID = 'I3'
   ORDER BY SectionID;
   ```


## Check your work

- [`solution.sql`](solution.sql)

The expected output for every query is in the comments above it. Statements that are supposed to fail are commented out, so the file runs cleanly. Uncomment one to watch the database reject it.

SQLite users: the solution files turn on `PRAGMA foreign_keys = ON;`, because SQLite ignores foreign keys without it.

---

© 2026 John Conklin. Text licensed under [CC BY 4.0](https://creativecommons.org/licenses/by/4.0/). SQL code licensed under the [MIT License](../../../LICENSE).
