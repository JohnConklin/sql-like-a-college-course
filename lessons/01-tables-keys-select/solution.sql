-- SPDX-License-Identifier: MIT
-- Copyright (c) 2026 John Conklin
-- Lesson 01: Tables, Keys and SELECT - solutions
-- Build the database first: sqlite3 campus.db < ../../database/campus.sql
-- Then run: sqlite3 campus.db < solution.sql

-- P1
SELECT first_name, last_name, major FROM students;
-- P2
SELECT course_id, title, credits FROM courses;
-- P3 (expected: UNIQUE constraint failed: students.student_id)
-- INSERT INTO students VALUES (1,'Test','User','CS',3.0,2026,'t@campus.edu');
