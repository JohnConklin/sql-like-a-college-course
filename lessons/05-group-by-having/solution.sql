-- Lesson 05: GROUP BY and HAVING - solutions
-- Build the database first: sqlite3 campus.db < ../../database/campus.sql
-- Then run: sqlite3 campus.db < solution.sql

-- P1
SELECT major, COUNT(*) AS n FROM students GROUP BY major ORDER BY n DESC;
-- P2
SELECT course_id, COUNT(*) AS fall_enrollment FROM enrollments
WHERE term = '2026FA' GROUP BY course_id HAVING COUNT(*) >= 2 ORDER BY fall_enrollment DESC;
-- P3 TRAP: aggregate in WHERE is an error; use HAVING
-- wrong: SELECT major, AVG(gpa) FROM students WHERE AVG(gpa) > 3.3 GROUP BY major;
SELECT major, ROUND(AVG(gpa),2) AS avg_gpa FROM students
WHERE major IS NOT NULL GROUP BY major HAVING AVG(gpa) > 3.3;
