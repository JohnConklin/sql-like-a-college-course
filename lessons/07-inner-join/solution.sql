-- Lesson 07: INNER JOIN - solutions
-- Build the database first: sqlite3 campus.db < ../../database/campus.sql
-- Then run: sqlite3 campus.db < solution.sql

-- P1
SELECT c.course_id, c.title, i.last_name AS instructor
FROM courses c JOIN instructors i ON c.instructor_id = i.instructor_id ORDER BY c.course_id;
-- P2
SELECT s.first_name, s.last_name, c.title, e.grade
FROM enrollments e
JOIN students s ON e.student_id = s.student_id
JOIN courses  c ON e.course_id  = c.course_id
WHERE e.term = '2026SP' AND e.grade = 'A' ORDER BY s.last_name;
-- P3 TRAP: BUS100 silently disappears (NULL instructor) -> 9 rows not 10
SELECT COUNT(*) AS joined_rows FROM courses c JOIN instructors i ON c.instructor_id = i.instructor_id;
