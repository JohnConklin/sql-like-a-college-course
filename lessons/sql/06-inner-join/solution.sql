-- SPDX-License-Identifier: MIT
-- Copyright (c) 2026 John Conklin
-- SQL · Lesson 6: SQL INNER JOIN Explained Step by Step (With Exam Problems)
-- Database: campus
-- Build the database first:  sqlite3 campus.db < ../../../database/campus.sql
-- Then run:                  sqlite3 campus.db < solution.sql
-- Every query below was tested in SQLite and PostgreSQL 18.
-- Statements that are SUPPOSED to fail are commented out. Uncomment one to watch it fail.

PRAGMA foreign_keys = ON;   -- SQLite only; PostgreSQL always enforces foreign keys
.headers on
.mode column

-- ===== G1 (free-sample Problem 1) =====
-- Expected:
-- | StudentID | Name | SectionID |
-- | 10021 | Ana Garcia | S3 |
-- | 10021 | Ana Garcia | S6 |
-- | 10021 | Ana Garcia | S7 |
-- | 10025 | Tran Nguyen | S4 |
-- | 10025 | Tran Nguyen | S6 |
-- | 10028 | Leo Martinez | S6 |
-- | 10028 | Leo Martinez | S7 |
SELECT s.StudentID, s.Name, e.SectionID
FROM Student AS s
JOIN Enrollment AS e
  ON e.StudentID = s.StudentID
WHERE s.Major = 'Information Systems'
ORDER BY s.StudentID, e.SectionID;

-- ===== G1-wrong (no join condition) =====
-- Expected:
-- | RowsReturned |
-- | 69 |
SELECT COUNT(*) AS RowsReturned
FROM Student AS s, Enrollment AS e
WHERE s.Major = 'Information Systems';

-- ===== G2 =====
-- Expected:
-- | SectionID | Title | Credits |
-- | S2 | Intro to Programming | 3 |
-- | S4 | Database Systems | 3 |
SELECT s.SectionID, c.Title, c.Credits
FROM Section AS s
JOIN Course AS c
  ON c.CourseID = s.CourseID
JOIN Instructor AS i
  ON i.InstructorID = s.InstructorID
WHERE i.Name = 'Dr. Kim'
ORDER BY s.SectionID;

-- ===== G3 =====
-- Expected:
-- | SectionID | CourseID | Name |
-- | S1 | CS101 | Dr. Shah |
-- | S2 | CS101 | Dr. Kim |
-- | S3 | CS250 | Dr. Shah |
-- | S4 | CS250 | Dr. Kim |
-- | S6 | IS200 | Dr. Ortiz |
-- | S7 | IS340 | Dr. Ortiz |
-- | S8 | IS200 | Dr. Ortiz |
SELECT s.SectionID, s.CourseID, i.Name
FROM Section AS s
JOIN Instructor AS i
  ON i.InstructorID = s.InstructorID
ORDER BY s.SectionID;

-- ===== G3-count =====
-- Expected:
-- | Sections |
-- | 8 |
SELECT COUNT(*) AS Sections
FROM Section;
