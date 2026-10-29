-- SPDX-License-Identifier: MIT
-- Copyright (c) 2026 John Conklin
-- Lesson 06: Keys and Relationships (Design) - solutions
-- Build the database first: sqlite3 campus.db < ../../database/campus.sql
-- Then run: sqlite3 campus.db < solution.sql

-- P1: ERD answer
--   departments 1 ── M instructors     (instructors.dept_id)
--   departments 1 ── M courses         (courses.dept_id)
--   instructors 1 ── M courses         (courses.instructor_id, nullable = "TBA")
--   students    M ── N courses         through the junction table enrollments
--                                      (enrollments.student_id, enrollments.course_id)

-- P2: retakes prove why term is part of the composite primary key
SELECT * FROM enrollments WHERE student_id IN (5, 11) ORDER BY student_id, term;

-- P3 TRAP: student 99 does not exist.
-- SQLite only enforces foreign keys when this pragma is on (per connection):
-- PRAGMA foreign_keys = ON;
-- INSERT INTO enrollments VALUES (99, 'CS101', '2026FA', NULL);
--   -> Error: FOREIGN KEY constraint failed
