-- Lesson 09: Subqueries - solutions
-- Build the database first: sqlite3 campus.db < ../../database/campus.sql
-- Then run: sqlite3 campus.db < solution.sql

-- P1: above-average GPA
SELECT first_name, last_name, gpa FROM students
WHERE gpa > (SELECT AVG(gpa) FROM students) ORDER BY gpa DESC;
-- P2: students taking any IS course
SELECT first_name, last_name FROM students WHERE student_id IN
 (SELECT e.student_id FROM enrollments e JOIN courses c ON e.course_id = c.course_id WHERE c.dept_id = 2)
ORDER BY last_name;
-- P3 TRAP wrong: NOT IN + NULL (BUS100 has NULL instructor) returns nothing
SELECT first_name, last_name FROM instructors
WHERE instructor_id NOT IN (SELECT instructor_id FROM courses);
-- P3 right: NOT EXISTS (instructors who teach nothing)
SELECT first_name, last_name FROM instructors i
WHERE NOT EXISTS (SELECT 1 FROM courses c WHERE c.instructor_id = i.instructor_id);
