-- SPDX-License-Identifier: MIT
-- Copyright (c) 2026 John Conklin
-- SQL · Practice Test: SQL Practice Test: 10 Questions Explained (Beginner)
-- Database: campus
-- Build the database first:  sqlite3 campus.db < ../../../database/campus.sql
-- Then run:                  sqlite3 campus.db < solution.sql
-- Every query below was tested in SQLite and PostgreSQL 18.
-- Statements that are SUPPOSED to fail are commented out. Uncomment one to watch it fail.

PRAGMA foreign_keys = ON;   -- SQLite only; PostgreSQL always enforces foreign keys
.headers on
.mode column

-- ===== C1 (Question 1 answer) =====
-- Expected:
-- | CourseID | Title |
-- | CS310 | Data Structures |
-- | MA210 | Discrete Math |
SELECT CourseID, Title
FROM Course
WHERE Credits = 4
ORDER BY CourseID;

-- ===== C2 (Question 2) =====
-- Expected:
-- | Major |
-- | Computer Science |
-- | Data Analytics |
-- | Information Systems |
-- | Mathematics |
SELECT DISTINCT Major
FROM Student
ORDER BY Major;

-- ===== C3-wrong (returns 0 rows) =====
-- Expected: 0 rows.
SELECT SectionID, CourseID, Term
FROM Section
WHERE InstructorID = NULL;

-- ===== C3 (Question 3 answer) =====
-- Expected:
-- | SectionID | CourseID | Term |
-- | S5 | CS310 | Fall 2026 |
SELECT SectionID, CourseID, Term
FROM Section
WHERE InstructorID IS NULL;

-- ===== C4 (Question 4) =====
-- Expected:
-- | AllSections | WithInstructor |
-- | 8 | 7 |
SELECT COUNT(*) AS AllSections,
       COUNT(InstructorID) AS WithInstructor
FROM Section;

-- ===== C5-wrong (also the slide 1 hook) =====
-- Expected:
-- | StudentID | Name | Major |
-- | 10022 | Jordan Lee | Computer Science |
-- | 10024 | Maya Patel | Computer Science |
-- | 10026 | Sam Whitfield | Computer Science |
-- | 10028 | Leo Martinez | Information Systems |
-- | 10029 | Grace Okafor | Computer Science |
SELECT StudentID, Name, Major
FROM Student
WHERE Major = 'Computer Science'
   OR Major = 'Information Systems'
  AND StudentID > 10025
ORDER BY StudentID;

-- ===== C5 (Question 5 answer) =====
-- Expected:
-- | StudentID | Name | Major |
-- | 10026 | Sam Whitfield | Computer Science |
-- | 10028 | Leo Martinez | Information Systems |
-- | 10029 | Grace Okafor | Computer Science |
SELECT StudentID, Name, Major
FROM Student
WHERE (Major = 'Computer Science'
    OR Major = 'Information Systems')
  AND StudentID > 10025
ORDER BY StudentID;

-- ===== C6 (Question 6) =====
-- Expected:
-- | CourseID | Title |
-- | CS250 | Database Systems |
-- | CS310 | Data Structures |
-- | IS340 | Data Analytics |
SELECT CourseID, Title
FROM Course
WHERE Title LIKE '%Data%'
ORDER BY CourseID;

-- ===== C7-wrong (Question 7; returns 3) =====
-- Expected:
-- | AvgCredits |
-- | 3 |
SELECT SUM(Credits) / COUNT(*) AS AvgCredits
FROM Course;

-- ===== C7 (the fix) =====
-- Expected:
-- | AvgCredits |
-- | 3.33 |
SELECT ROUND(AVG(Credits), 2) AS AvgCredits
FROM Course;

-- ===== C8 (Question 8) =====
-- Expected:
-- | SectionID | CourseID | Name |
-- | S1 | CS101 | Dr. Shah |
-- | S2 | CS101 | Dr. Kim |
-- | S4 | CS250 | Dr. Kim |
-- | S7 | IS340 | Dr. Ortiz |
-- | S8 | IS200 | Dr. Ortiz |
SELECT s.SectionID, s.CourseID, i.Name
FROM Section AS s
JOIN Instructor AS i
  ON s.InstructorID = i.InstructorID
WHERE s.Term = 'Fall 2026'
ORDER BY s.SectionID;

-- ===== C9 (Question 9 answer) =====
-- Expected:
-- | Major | Students |
-- | Computer Science | 4 |
-- | Information Systems | 3 |
SELECT Major, COUNT(*) AS Students
FROM Student
GROUP BY Major
HAVING COUNT(*) >= 3
ORDER BY Students DESC;

-- ===== C10 (Question 10 answer) =====
-- Expected:
-- | CourseID | Title |
-- | MA210 | Discrete Math |
SELECT c.CourseID, c.Title
FROM Course AS c
LEFT JOIN Section AS s
  ON c.CourseID = s.CourseID
WHERE s.SectionID IS NULL;
