-- SPDX-License-Identifier: MIT
-- Copyright (c) 2026 John Conklin
-- Database Design · Lesson 1: Primary vs Foreign Keys: Explained Like a College Course
-- Database: campus
-- Build the database first:  sqlite3 campus.db < ../../../database/campus.sql
-- Then run:                  sqlite3 campus.db < solution.sql
-- Every query below was tested in SQLite and PostgreSQL 18.
-- Statements that are SUPPOSED to fail are commented out. Uncomment one to watch it fail.

PRAGMA foreign_keys = ON;   -- SQLite only; PostgreSQL always enforces foreign keys
.headers on
.mode column

-- ===== L1-1 (slide 7 proof: names repeat) =====
-- Expected:
-- | Name | Students |
-- | Jordan Lee | 2 |
SELECT Name, COUNT(*) AS Students
FROM Student
GROUP BY Name
HAVING COUNT(*) > 1;

-- ===== L1-2 (slide 9: one instructor, many sections) =====
-- Expected:
-- | SectionID | CourseID | Term |
-- | S6 | IS200 | Spring 2026 |
-- | S7 | IS340 | Fall 2026 |
-- | S8 | IS200 | Fall 2026 |
SELECT SectionID, CourseID, Term
FROM Section
WHERE InstructorID = 'I3'
ORDER BY SectionID;

-- ===== L1-3a =====
-- Expected: error. SQLite: "FOREIGN KEY constraint failed." PostgreSQL: "violates foreign key constraint."
-- INSERT INTO Section VALUES ('S9', 'CS101', 'Spring 2027', 'I9');

-- ===== L1-3b =====
-- Expected: accepted.
BEGIN;
INSERT INTO Section VALUES ('S9', 'CS310', 'Spring 2027', NULL);
ROLLBACK;   -- undo, so later queries see the original data

-- ===== L1-3c =====
-- Expected: accepted.
BEGIN;
DELETE FROM Instructor WHERE InstructorID = 'I5';
ROLLBACK;   -- undo, so later queries see the original data

-- ===== L1-3d =====
-- Expected: error. SQLite: "FOREIGN KEY constraint failed." PostgreSQL: "violates foreign key constraint."
-- DELETE FROM Instructor WHERE InstructorID = 'I3';

-- ===== L1-3e =====
-- Expected: error. SQLite: "UNIQUE constraint failed: Section.SectionID." PostgreSQL: "duplicate key value violates unique constraint."
-- INSERT INTO Section VALUES ('S1', 'CS250', 'Spring 2027', 'I2');

-- ===== L1-3f (SQLite with foreign keys off, the default) =====
-- Expected: accepted. This is the hook's bad row. Turn the check on with `PRAGMA foreign_keys = ON;`.
PRAGMA foreign_keys = OFF;
BEGIN;
-- SQLite with foreign keys OFF
INSERT INTO Section VALUES ('S9', 'CS101', 'Spring 2027', 'I9');
ROLLBACK;   -- undo, so later queries see the original data
PRAGMA foreign_keys = ON;
