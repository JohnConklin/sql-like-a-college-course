-- SPDX-License-Identifier: MIT
-- Copyright (c) 2026 John Conklin
-- SQL · Lesson 1: The SQL JOIN Mistake That Costs Students Points
-- Database: campus
-- Build the database first:  sqlite3 campus.db < ../../../database/campus.sql
-- Then run:                  sqlite3 campus.db < solution.sql
-- Every query below was tested in SQLite and PostgreSQL 18.
-- Statements that are SUPPOSED to fail are commented out. Uncomment one to watch it fail.

PRAGMA foreign_keys = ON;   -- SQLite only; PostgreSQL always enforces foreign keys
.headers on
.mode column

-- ===== A1-wrong (returns 0 rows) =====
-- Expected: 0 rows.
SELECT st.Name
FROM Student AS st
JOIN Enrollment AS e
  ON st.StudentID = e.StudentID
WHERE e.SectionID IS NULL;

-- ===== A1 (Problem 1 answer) =====
-- Expected:
-- | StudentID | Name |
-- | 10030 | Ben Ortiz |
SELECT st.StudentID, st.Name
FROM Student AS st
LEFT JOIN Enrollment AS e
  ON st.StudentID = e.StudentID
WHERE e.StudentID IS NULL;

-- ===== A2-wrong (also the slide 1 hook) =====
-- Expected:
-- | Name | SectionID |
-- | Dr. Kim | S2 |
-- | Dr. Kim | S4 |
-- | Dr. Ortiz | S7 |
-- | Dr. Ortiz | S8 |
-- | Dr. Shah | S1 |
SELECT i.Name, s.SectionID
FROM Instructor AS i
LEFT JOIN Section AS s
  ON i.InstructorID = s.InstructorID
WHERE s.Term = 'Fall 2026'
ORDER BY i.Name, s.SectionID;

-- ===== A2 (Problem 2 answer) =====
-- Expected:
-- | Name | SectionID |
-- | Dr. Brooks | NULL |
-- | Dr. Chen | NULL |
-- | Dr. Kim | S2 |
-- | Dr. Kim | S4 |
-- | Dr. Ortiz | S7 |
-- | Dr. Ortiz | S8 |
-- | Dr. Shah | S1 |
SELECT i.Name, s.SectionID
FROM Instructor AS i
LEFT JOIN Section AS s
  ON i.InstructorID = s.InstructorID
 AND s.Term = 'Fall 2026'
ORDER BY i.Name, s.SectionID;

-- ===== A3-wrong =====
-- Expected:
-- | Name | FallSections |
-- | Dr. Brooks | 1 |
-- | Dr. Chen | 1 |
-- | Dr. Kim | 2 |
-- | Dr. Ortiz | 2 |
-- | Dr. Shah | 1 |
SELECT i.Name, COUNT(*) AS FallSections
FROM Instructor AS i
LEFT JOIN Section AS s
  ON i.InstructorID = s.InstructorID
 AND s.Term = 'Fall 2026'
GROUP BY i.InstructorID, i.Name
ORDER BY i.Name;

-- ===== A3 (Problem 3 answer) =====
-- Expected:
-- | Name | FallSections |
-- | Dr. Brooks | 0 |
-- | Dr. Chen | 0 |
-- | Dr. Kim | 2 |
-- | Dr. Ortiz | 2 |
-- | Dr. Shah | 1 |
SELECT i.Name, COUNT(s.SectionID) AS FallSections
FROM Instructor AS i
LEFT JOIN Section AS s
  ON i.InstructorID = s.InstructorID
 AND s.Term = 'Fall 2026'
GROUP BY i.InstructorID, i.Name
ORDER BY i.Name;
