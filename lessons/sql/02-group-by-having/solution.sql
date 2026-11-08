-- SPDX-License-Identifier: MIT
-- Copyright (c) 2026 John Conklin
-- SQL · Lesson 2: GROUP BY vs HAVING: 3 Exam Problems Solved
-- Database: campus
-- Build the database first:  sqlite3 campus.db < ../../../database/campus.sql
-- Then run:                  sqlite3 campus.db < solution.sql
-- Every query below was tested in SQLite and PostgreSQL 18.
-- Statements that are SUPPOSED to fail are commented out. Uncomment one to watch it fail.

PRAGMA foreign_keys = ON;   -- SQLite only; PostgreSQL always enforces foreign keys
.headers on
.mode column

-- ===== B1-wrong (the hook; 8 rows) =====
-- Expected:
-- | SectionID | Title | Enrollments |
-- | S1 | Intro to Programming | 3 |
-- | S2 | Intro to Programming | 2 |
-- | S3 | Database Systems | 4 |
-- | S4 | Database Systems | 3 |
-- | S5 | Data Structures | 2 |
-- | S6 | Web Development | 4 |
-- | S7 | Data Analytics | 3 |
-- | S8 | Web Development | 2 |
SELECT s.SectionID, c.Title, COUNT(*) AS Enrollments
FROM Course AS c
JOIN Section AS s
  ON c.CourseID = s.CourseID
JOIN Enrollment AS e
  ON s.SectionID = e.SectionID
GROUP BY s.SectionID, c.Title
ORDER BY s.SectionID;

-- ===== B1 (Problem 1 answer) =====
-- Expected:
-- | CourseID | Title | Enrollments |
-- | CS250 | Database Systems | 7 |
-- | IS200 | Web Development | 6 |
-- | CS101 | Intro to Programming | 5 |
-- | IS340 | Data Analytics | 3 |
-- | CS310 | Data Structures | 2 |
SELECT c.CourseID, c.Title, COUNT(*) AS Enrollments
FROM Course AS c
JOIN Section AS s
  ON c.CourseID = s.CourseID
JOIN Enrollment AS e
  ON s.SectionID = e.SectionID
GROUP BY c.CourseID, c.Title
ORDER BY Enrollments DESC;

-- ===== B1-distinct (the footnote; Database Systems drops to 6) =====
-- Expected:
-- | CourseID | Students |
-- | CS250 | 6 |
SELECT c.CourseID, COUNT(DISTINCT e.StudentID) AS Students
FROM Course AS c
JOIN Section AS s
  ON c.CourseID = s.CourseID
JOIN Enrollment AS e
  ON s.SectionID = e.SectionID
WHERE c.CourseID = 'CS250'
GROUP BY c.CourseID;

-- ===== B2-nofilter (runs, but it's wrong because it counts all terms) =====
-- Expected:
-- | CourseID | Title | Enrollments |
-- | CS101 | Intro to Programming | 5 |
-- | CS250 | Database Systems | 7 |
-- | IS200 | Web Development | 6 |
SELECT c.CourseID, c.Title, COUNT(*) AS Enrollments
FROM Course AS c
JOIN Section AS s
  ON c.CourseID = s.CourseID
JOIN Enrollment AS e
  ON s.SectionID = e.SectionID
GROUP BY c.CourseID, c.Title
HAVING COUNT(*) > 3
ORDER BY c.CourseID;

-- ===== B2 (Problem 2 answer) =====
-- Expected:
-- | CourseID | Title | FallEnrollments |
-- | CS101 | Intro to Programming | 5 |
SELECT c.CourseID, c.Title, COUNT(*) AS FallEnrollments
FROM Course AS c
JOIN Section AS s
  ON c.CourseID = s.CourseID
JOIN Enrollment AS e
  ON s.SectionID = e.SectionID
WHERE s.Term = 'Fall 2026'
GROUP BY c.CourseID, c.Title
HAVING COUNT(*) > 3
ORDER BY c.CourseID;

-- ===== B2-check (the boundary check, without HAVING) =====
-- Expected:
-- | CourseID | FallEnrollments |
-- | CS101 | 5 |
-- | CS250 | 3 |
-- | CS310 | 2 |
-- | IS200 | 2 |
-- | IS340 | 3 |
SELECT c.CourseID, COUNT(*) AS FallEnrollments
FROM Course AS c
JOIN Section AS s
  ON c.CourseID = s.CourseID
JOIN Enrollment AS e
  ON s.SectionID = e.SectionID
WHERE s.Term = 'Fall 2026'
GROUP BY c.CourseID
ORDER BY c.CourseID;

-- ===== B3-wrong =====
-- Expected:
-- | Name | FallSections |
-- | Grace Okafor | 3 |
-- | Jordan Lee | 4 |
-- | Maya Patel | 2 |
-- | Priya Nair | 2 |
SELECT st.Name, COUNT(*) AS FallSections
FROM Student AS st
JOIN Enrollment AS e
  ON st.StudentID = e.StudentID
JOIN Section AS s
  ON e.SectionID = s.SectionID
WHERE s.Term = 'Fall 2026'
GROUP BY st.Name
HAVING COUNT(*) >= 2
ORDER BY st.Name;

-- ===== B3 (Problem 3 answer) =====
-- Expected:
-- | StudentID | Name | FallSections |
-- | 10022 | Jordan Lee | 2 |
-- | 10023 | Jordan Lee | 2 |
-- | 10024 | Maya Patel | 2 |
-- | 10027 | Priya Nair | 2 |
-- | 10029 | Grace Okafor | 3 |
SELECT st.StudentID, st.Name, COUNT(*) AS FallSections
FROM Student AS st
JOIN Enrollment AS e
  ON st.StudentID = e.StudentID
JOIN Section AS s
  ON e.SectionID = s.SectionID
WHERE s.Term = 'Fall 2026'
GROUP BY st.StudentID, st.Name
HAVING COUNT(*) >= 2
ORDER BY st.StudentID;
