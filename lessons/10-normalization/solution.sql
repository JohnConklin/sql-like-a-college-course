-- Lesson 10: Normalization (1NF to 3NF) - solutions
-- Build the database first: sqlite3 campus.db < ../../database/campus.sql
-- Then run: sqlite3 campus.db < solution.sql

-- Look at the bad table
SELECT * FROM signup_sheet;

-- P1 (1NF): "courses" holds a comma-separated list (not atomic).
--   Fix: one row per student per course -> the enrollments table.

-- P2 (2NF / 3NF):
--   instructor    depends on the COURSE, not the student      -> courses.instructor_id -> instructors
--   dept_building depends on the DEPARTMENT (transitive)       -> departments.building
--   student_name / student_email / major describe the STUDENT -> students
--   Result: exactly the five campus tables
--   (departments, instructors, courses, students, enrollments).

-- P3 TRAP: update anomaly - same person, two emails, two spellings of the major
SELECT student_name,
       COUNT(DISTINCT student_email) AS emails,
       COUNT(DISTINCT major)         AS majors
FROM signup_sheet
GROUP BY student_name
HAVING COUNT(*) > 1;
