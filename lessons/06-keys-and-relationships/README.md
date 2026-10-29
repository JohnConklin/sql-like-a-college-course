# Lesson 6: Keys and Relationships (Design)

Primary keys, foreign keys, one-to-many and many-to-many relationships, and junction tables.

**Video:** _link coming soon_
**Database:** [`database/campus.sql`](../../database/campus.sql)

## Prove it

Pause the video and try each problem before looking at the solution.

1. Draw the ERD for the five campus tables, and label each relationship as 1:M or M:N.
2. Why is the enrollments primary key `(student_id, course_id, term)` instead of `(student_id, course_id)`? Find evidence in the data.
3. **Trap:** Enroll student 99 in CS101 for 2026FA. What happens? (In SQLite, try it with and without `PRAGMA foreign_keys = ON`.)

## Solution

Try the problems before opening [`solution.sql`](solution.sql).
