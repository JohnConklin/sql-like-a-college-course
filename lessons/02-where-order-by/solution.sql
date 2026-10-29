-- SPDX-License-Identifier: MIT
-- Copyright (c) 2026 John Conklin
-- Lesson 02: WHERE and ORDER BY - solutions
-- Build the database first: sqlite3 campus.db < ../../database/campus.sql
-- Then run: sqlite3 campus.db < solution.sql

-- P1
SELECT first_name, last_name, gpa FROM students WHERE gpa >= 3.5 ORDER BY gpa DESC;
-- P2
SELECT first_name, last_name, enroll_year FROM students
WHERE major = 'Computer Science' AND enroll_year <= 2023 ORDER BY last_name;
-- P3 TRAP wrong (AND binds tighter than OR)
SELECT first_name, major, gpa FROM students
WHERE major = 'Computer Science' OR major = 'Mathematics' AND gpa > 3.5;
-- P3 right
SELECT first_name, major, gpa FROM students
WHERE (major = 'Computer Science' OR major = 'Mathematics') AND gpa > 3.5;
