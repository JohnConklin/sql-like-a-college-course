# SQL · Practice Test: SQL Practice Test: 10 Questions Explained (Beginner)

Beginner · 1 point each · pause before every answer.

- **Video:** publishes Tue, Jan 26, 2027. Link coming soon.
- **Database:** [`database/campus.sql`](../../../database/campus.sql)

## Prove it

Pause the video and try each problem before you look at the solution.

1. **Write it** List the CourseID and Title of every 4-credit course.

2. **Predict it** How many rows does this return?

   ```sql
   SELECT DISTINCT Major
   FROM Student
   ORDER BY Major;
   ```

3. **Find the bug** Goal: find sections with no instructor assigned. Result: 0 rows.

   ```sql
   SELECT SectionID, CourseID, Term
   FROM Section
   WHERE InstructorID = NULL;
   ```

4. **Predict it** What two numbers come back?

   ```sql
   SELECT COUNT(*) AS AllSections,
          COUNT(InstructorID) AS WithInstructor
   FROM Section;
   ```

5. **Find the bug** Goal: Computer Science or Information Systems majors with StudentID above 10025.

   ```sql
   SELECT StudentID, Name, Major
   FROM Student
   WHERE Major = 'Computer Science'
      OR Major = 'Information Systems'
     AND StudentID > 10025
   ORDER BY StudentID;
   ```

6. **Predict it** How many courses come back?

   ```sql
   SELECT CourseID, Title
   FROM Course
   WHERE Title LIKE '%Data%'
   ORDER BY CourseID;
   ```

7. **Predict it** What's the average credits per course?

   ```sql
   SELECT SUM(Credits) / COUNT(*) AS AvgCredits
   FROM Course;
   ```

8. **Predict it** 6 sections are in Fall 2026. How many rows come back?

   ```sql
   SELECT s.SectionID, s.CourseID, i.Name
   FROM Section AS s
   JOIN Instructor AS i
     ON s.InstructorID = i.InstructorID
   WHERE s.Term = 'Fall 2026'
   ORDER BY s.SectionID;
   ```

9. **Write it** Show each major with its number of students, but only majors with at least 3 students. Highest first.

10. **Write it** Find every course that has never had a section.


## Check your work

- [`solution.sql`](solution.sql)

The expected output for every query is in the comments above it. Statements that are supposed to fail are commented out, so the file runs cleanly. Uncomment one to watch the database reject it.

SQLite users: the solution files turn on `PRAGMA foreign_keys = ON;`, because SQLite ignores foreign keys without it.

---

© 2026 John Conklin. Text licensed under [CC BY 4.0](https://creativecommons.org/licenses/by/4.0/). SQL code licensed under the [MIT License](../../../LICENSE).
