# Database Design · Lesson 1: Primary vs Foreign Keys: Explained Like a College Course

What makes a key, where the foreign key goes, and what it blocks.

- **Video:** publishes Tue, Nov 10, 2026. Link coming soon.
- **Database:** [`database/campus.sql`](../../../database/campus.sql)

## Prove it

Pause the video and try each problem before you look at the solution.

1. **Easy** Use this Student table: StudentID, Email, Name, Major (10021 agarcia@univ.edu Ana Garcia IS; 10022 jlee@univ.edu Jordan Lee CS; 10023 jlee2@univ.edu Jordan Lee DA; 10024 mpatel@univ.edu Maya Patel CS; 10025 tnguyen@univ.edu Tran Nguyen IS). Rules: StudentID is unique and never changes. Each email is unique, but it can change. Names can repeat. a. List every candidate key. b. Pick the primary key. c. Why isn't Name a key?

2. **Medium** One instructor teaches many sections. Each section has at most one instructor. Where does the foreign key go? A: InstructorID in Section. B: SectionID in Instructor. C: Both.

3. **Hard** Foreign keys are ON. Which statements are rejected?

   **a.**

   ```sql
   INSERT INTO Section VALUES ('S9', 'CS101', 'Spring 2027', 'I9');
   ```

   **b.**

   ```sql
   INSERT INTO Section VALUES ('S9', 'CS310', 'Spring 2027', NULL);
   ```

   **c.**

   ```sql
   DELETE FROM Instructor WHERE InstructorID = 'I5';
   ```

   **d.**

   ```sql
   DELETE FROM Instructor WHERE InstructorID = 'I3';
   ```

   **e.**

   ```sql
   INSERT INTO Section VALUES ('S1', 'CS250', 'Spring 2027', 'I2');
   ```


## Check your work

- [`solution.sql`](solution.sql)

The expected output for every query is in the comments above it. Statements that are supposed to fail are commented out, so the file runs cleanly. Uncomment one to watch the database reject it.

SQLite users: the solution files turn on `PRAGMA foreign_keys = ON;`, because SQLite ignores foreign keys without it.

---

© 2026 John Conklin. Text licensed under [CC BY 4.0](https://creativecommons.org/licenses/by/4.0/). SQL code licensed under the [MIT License](../../../LICENSE).
