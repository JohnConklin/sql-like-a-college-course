-- SPDX-License-Identifier: MIT
-- Copyright (c) 2026 John Conklin
-- SQL · Lesson 3: SQL WHERE and ORDER BY: The AND/OR Mistake That Costs Exam Points
-- Database: campus
-- Build the database first:  sqlite3 campus.db < ../../../database/campus.sql
-- Then run:                  sqlite3 campus.db < solution.sql
-- Every query below was tested in SQLite and PostgreSQL 18.
-- Statements that are SUPPOSED to fail are commented out. Uncomment one to watch it fail.

PRAGMA foreign_keys = ON;   -- SQLite only; PostgreSQL always enforces foreign keys
.headers on
.mode column

-- ===== D1 =====
-- Expected:
-- | StudentID | Name |
-- | 10029 | Grace Okafor |
-- | 10022 | Jordan Lee |
-- | 10024 | Maya Patel |
-- | 10026 | Sam Whitfield |
SELECT StudentID, Name
FROM Student
WHERE Major = 'Computer Science'
ORDER BY Name;

-- ===== D2 =====
-- Expected:
-- | CourseID | Title | Credits |
-- | CS310 | Data Structures | 4 |
-- | MA210 | Discrete Math | 4 |
-- | IS340 | Data Analytics | 3 |
-- | CS250 | Database Systems | 3 |
-- | CS101 | Intro to Programming | 3 |
-- | IS200 | Web Development | 3 |
SELECT CourseID, Title, Credits
FROM Course
ORDER BY Credits DESC, Title;

-- ===== D3-wrong =====
-- Expected:
-- | SectionID | Term | InstructorID |
-- | S2 | Fall 2026 | I2 |
-- | S4 | Fall 2026 | I2 |
-- | S6 | Spring 2026 | I3 |
-- | S7 | Fall 2026 | I3 |
-- | S8 | Fall 2026 | I3 |
SELECT SectionID, Term, InstructorID
FROM Section
WHERE Term = 'Fall 2026'
  AND InstructorID = 'I2'
   OR InstructorID = 'I3'
ORDER BY SectionID;

-- ===== D3 =====
-- Expected:
-- | SectionID | Term | InstructorID |
-- | S2 | Fall 2026 | I2 |
-- | S4 | Fall 2026 | I2 |
-- | S7 | Fall 2026 | I3 |
-- | S8 | Fall 2026 | I3 |
SELECT SectionID, Term, InstructorID
FROM Section
WHERE Term = 'Fall 2026'
  AND (InstructorID = 'I2' OR InstructorID = 'I3')
ORDER BY SectionID;

-- ===== D4 (the same query sorts NULL differently in each database) =====
-- Expected in SQLite:
-- | SectionID | InstructorID |
-- | S5 | NULL |
-- | S1 | I1 |
-- | S3 | I1 |
-- | S2 | I2 |
-- | S4 | I2 |
-- | S6 | I3 |
-- | S7 | I3 |
-- | S8 | I3 |
-- Expected in PostgreSQL:
-- | SectionID | InstructorID |
-- | S1 | I1 |
-- | S3 | I1 |
-- | S2 | I2 |
-- | S4 | I2 |
-- | S6 | I3 |
-- | S7 | I3 |
-- | S8 | I3 |
-- | S5 | NULL |
-- Compare databases
SELECT SectionID, InstructorID
FROM Section
ORDER BY InstructorID, SectionID;

-- ===== D4-fix (same order in both) =====
-- Expected:
-- | SectionID | InstructorID |
-- | S1 | I1 |
-- | S3 | I1 |
-- | S2 | I2 |
-- | S4 | I2 |
-- | S6 | I3 |
-- | S7 | I3 |
-- | S8 | I3 |
-- | S5 | NULL |
SELECT SectionID, InstructorID
FROM Section
ORDER BY InstructorID NULLS LAST, SectionID;
