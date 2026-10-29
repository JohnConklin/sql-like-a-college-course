-- Lesson 04: COUNT, SUM, AVG, MIN, MAX - solutions
-- Build the database first: sqlite3 campus.db < ../../database/campus.sql
-- Then run: sqlite3 campus.db < solution.sql

-- P1
SELECT COUNT(*) AS total_students, ROUND(AVG(gpa),2) AS avg_gpa FROM students;
-- P2
SELECT MIN(hire_year) AS earliest, MAX(hire_year) AS latest FROM instructors;
-- P3 TRAP COUNT(*) vs COUNT(col)
SELECT COUNT(*) AS all_rows, COUNT(email) AS with_email, COUNT(gpa) AS with_gpa,
       COUNT(DISTINCT major) AS distinct_majors FROM students;
