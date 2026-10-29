-- Lesson 08: LEFT JOIN - solutions
-- Build the database first: sqlite3 campus.db < ../../database/campus.sql
-- Then run: sqlite3 campus.db < solution.sql

-- P1: students with no enrollments
SELECT s.first_name, s.last_name FROM students s
LEFT JOIN enrollments e ON s.student_id = e.student_id WHERE e.student_id IS NULL;
-- P2: enrollment count per course, including zero
SELECT c.course_id, COUNT(e.student_id) AS n FROM courses c
LEFT JOIN enrollments e ON c.course_id = e.course_id GROUP BY c.course_id ORDER BY n, c.course_id;
-- P3 TRAP wrong: WHERE on right table turns LEFT into INNER (IS400 vanishes)
SELECT c.course_id, COUNT(e.student_id) AS fall_n FROM courses c
LEFT JOIN enrollments e ON c.course_id = e.course_id
WHERE e.term = '2026FA' GROUP BY c.course_id ORDER BY c.course_id;
-- P3 right: move filter into ON
SELECT c.course_id, COUNT(e.student_id) AS fall_n FROM courses c
LEFT JOIN enrollments e ON c.course_id = e.course_id AND e.term = '2026FA'
GROUP BY c.course_id ORDER BY c.course_id;
