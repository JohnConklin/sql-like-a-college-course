-- SPDX-License-Identifier: MIT
-- Copyright (c) 2026 John Conklin
-- Lesson 03: IN, BETWEEN, LIKE and NULL - solutions
-- Build the database first: sqlite3 campus.db < ../../database/campus.sql
-- Then run: sqlite3 campus.db < solution.sql

-- P1
SELECT first_name, last_name, major FROM students
WHERE major IN ('Information Systems','Business') AND gpa BETWEEN 3.0 AND 3.5;
-- P2 TRAP LIKE Ann% also returns Anna
SELECT first_name FROM students WHERE first_name LIKE 'Ann%';
-- P3 TRAP wrong: = NULL returns nothing
SELECT first_name, last_name FROM students WHERE email = NULL;
-- P3 right
SELECT first_name, last_name FROM students WHERE email IS NULL;
