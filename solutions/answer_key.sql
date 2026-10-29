-- answer_key.sql : tested solutions for every "Prove it" problem (SQLite)
-- Run: sqlite3 campus.db < answer_key.sql

.headers on
.mode column

-- ===== L01 Tables, rows, keys =====
SELECT '-- L01 P1';
SELECT first_name, last_name, major FROM students;
SELECT '-- L01 P2';
SELECT course_id, title, credits FROM courses;
SELECT '-- L01 P3 (expected: UNIQUE constraint failed: students.student_id)';
-- INSERT INTO students VALUES (1,'Test','User','CS',3.0,2026,'t@campus.edu');

-- ===== L02 WHERE + ORDER BY =====
SELECT '-- L02 P1';
SELECT first_name, last_name, gpa FROM students WHERE gpa >= 3.5 ORDER BY gpa DESC;
SELECT '-- L02 P2';
SELECT first_name, last_name, enroll_year FROM students
WHERE major = 'Computer Science' AND enroll_year <= 2023 ORDER BY last_name;
SELECT '-- L02 P3 TRAP wrong (AND binds tighter than OR)';
SELECT first_name, major, gpa FROM students
WHERE major = 'Computer Science' OR major = 'Mathematics' AND gpa > 3.5;
SELECT '-- L02 P3 right';
SELECT first_name, major, gpa FROM students
WHERE (major = 'Computer Science' OR major = 'Mathematics') AND gpa > 3.5;

-- ===== L03 IN, BETWEEN, LIKE, NULL =====
SELECT '-- L03 P1';
SELECT first_name, last_name, major FROM students
WHERE major IN ('Information Systems','Business') AND gpa BETWEEN 3.0 AND 3.5;
SELECT '-- L03 P2 TRAP LIKE Ann% also returns Anna';
SELECT first_name FROM students WHERE first_name LIKE 'Ann%';
SELECT '-- L03 P3 TRAP wrong: = NULL returns nothing';
SELECT first_name, last_name FROM students WHERE email = NULL;
SELECT '-- L03 P3 right';
SELECT first_name, last_name FROM students WHERE email IS NULL;

-- ===== L04 Aggregates =====
SELECT '-- L04 P1';
SELECT COUNT(*) AS total_students, ROUND(AVG(gpa),2) AS avg_gpa FROM students;
SELECT '-- L04 P2';
SELECT MIN(hire_year) AS earliest, MAX(hire_year) AS latest FROM instructors;
SELECT '-- L04 P3 TRAP COUNT(*) vs COUNT(col)';
SELECT COUNT(*) AS all_rows, COUNT(email) AS with_email, COUNT(gpa) AS with_gpa,
       COUNT(DISTINCT major) AS distinct_majors FROM students;

-- ===== L05 GROUP BY + HAVING =====
SELECT '-- L05 P1';
SELECT major, COUNT(*) AS n FROM students GROUP BY major ORDER BY n DESC;
SELECT '-- L05 P2';
SELECT course_id, COUNT(*) AS fall_enrollment FROM enrollments
WHERE term = '2026FA' GROUP BY course_id HAVING COUNT(*) >= 2 ORDER BY fall_enrollment DESC;
SELECT '-- L05 P3 TRAP: aggregate in WHERE is an error; use HAVING';
-- wrong: SELECT major, AVG(gpa) FROM students WHERE AVG(gpa) > 3.3 GROUP BY major;
SELECT major, ROUND(AVG(gpa),2) AS avg_gpa FROM students
WHERE major IS NOT NULL GROUP BY major HAVING AVG(gpa) > 3.3;

-- ===== L06 Keys + relationships (design) =====
SELECT '-- L06 P3 TRAP (expected: FOREIGN KEY constraint failed)';
-- PRAGMA foreign_keys = ON;
-- INSERT INTO enrollments VALUES (99,'CS101','2026FA',NULL);
SELECT '-- L06 P2: retake proves why term is in the composite PK';
SELECT * FROM enrollments WHERE student_id IN (5,11) ORDER BY student_id, term;

-- ===== L07 INNER JOIN =====
SELECT '-- L07 P1';
SELECT c.course_id, c.title, i.last_name AS instructor
FROM courses c JOIN instructors i ON c.instructor_id = i.instructor_id ORDER BY c.course_id;
SELECT '-- L07 P2';
SELECT s.first_name, s.last_name, c.title, e.grade
FROM enrollments e
JOIN students s ON e.student_id = s.student_id
JOIN courses  c ON e.course_id  = c.course_id
WHERE e.term = '2026SP' AND e.grade = 'A' ORDER BY s.last_name;
SELECT '-- L07 P3 TRAP: BUS100 silently disappears (NULL instructor) -> 9 rows not 10';
SELECT COUNT(*) AS joined_rows FROM courses c JOIN instructors i ON c.instructor_id = i.instructor_id;

-- ===== L08 LEFT JOIN =====
SELECT '-- L08 P1: students with no enrollments';
SELECT s.first_name, s.last_name FROM students s
LEFT JOIN enrollments e ON s.student_id = e.student_id WHERE e.student_id IS NULL;
SELECT '-- L08 P2: enrollment count per course, including zero';
SELECT c.course_id, COUNT(e.student_id) AS n FROM courses c
LEFT JOIN enrollments e ON c.course_id = e.course_id GROUP BY c.course_id ORDER BY n, c.course_id;
SELECT '-- L08 P3 TRAP wrong: WHERE on right table turns LEFT into INNER (IS400 vanishes)';
SELECT c.course_id, COUNT(e.student_id) AS fall_n FROM courses c
LEFT JOIN enrollments e ON c.course_id = e.course_id
WHERE e.term = '2026FA' GROUP BY c.course_id ORDER BY c.course_id;
SELECT '-- L08 P3 right: move filter into ON';
SELECT c.course_id, COUNT(e.student_id) AS fall_n FROM courses c
LEFT JOIN enrollments e ON c.course_id = e.course_id AND e.term = '2026FA'
GROUP BY c.course_id ORDER BY c.course_id;

-- ===== L09 Subqueries =====
SELECT '-- L09 P1: above-average GPA';
SELECT first_name, last_name, gpa FROM students
WHERE gpa > (SELECT AVG(gpa) FROM students) ORDER BY gpa DESC;
SELECT '-- L09 P2: students taking any IS course';
SELECT first_name, last_name FROM students WHERE student_id IN
 (SELECT e.student_id FROM enrollments e JOIN courses c ON e.course_id = c.course_id WHERE c.dept_id = 2)
ORDER BY last_name;
SELECT '-- L09 P3 TRAP wrong: NOT IN + NULL (BUS100 has NULL instructor) returns nothing';
SELECT first_name, last_name FROM instructors
WHERE instructor_id NOT IN (SELECT instructor_id FROM courses);
SELECT '-- L09 P3 right: NOT EXISTS (instructors who teach nothing)';
SELECT first_name, last_name FROM instructors i
WHERE NOT EXISTS (SELECT 1 FROM courses c WHERE c.instructor_id = i.instructor_id);

-- ===== L10 Normalization =====
SELECT '-- L10 P1: the bad table';
SELECT * FROM signup_sheet;
SELECT '-- L10 P3: update anomaly - same person, two emails, two major spellings';
SELECT student_name, COUNT(DISTINCT student_email) AS emails, COUNT(DISTINCT major) AS majors
FROM signup_sheet GROUP BY student_name HAVING COUNT(*) > 1;
