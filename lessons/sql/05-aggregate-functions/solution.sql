-- SPDX-License-Identifier: MIT
-- Copyright (c) 2026 John Conklin
-- SQL · Lesson 5: SQL COUNT, SUM, AVG Explained: COUNT(*) vs COUNT(column)
-- Database: campus
-- Build the database first:  sqlite3 campus.db < ../../../database/campus.sql
-- Then run:                  sqlite3 campus.db < solution.sql
-- Every query below was tested in SQLite and PostgreSQL 18.
-- Statements that are SUPPOSED to fail are commented out. Uncomment one to watch it fail.

PRAGMA foreign_keys = ON;   -- SQLite only; PostgreSQL always enforces foreign keys
.headers on
.mode column

-- ===== F1 =====
-- Expected:
-- | AllRows | Graded | Students |
-- | 23 | 8 | 9 |
SELECT COUNT(*) AS AllRows,
       COUNT(Grade) AS Graded,
       COUNT(DISTINCT StudentID) AS Students
FROM Enrollment;

-- ===== F2 =====
-- Expected:
-- | Lowest | Highest | Average |
-- | 2.0 | 4.0 | 3.38 |
SELECT MIN(GradePoints) AS Lowest,
       MAX(GradePoints) AS Highest,
       ROUND(AVG(GradePoints), 2) AS Average
FROM Enrollment
WHERE Grade IS NOT NULL;

-- ===== F2-nowhere (slide 8: the same average without the WHERE) =====
-- Expected:
-- | Average |
-- | 3.38 |
SELECT ROUND(AVG(GradePoints), 2) AS Average
FROM Enrollment;

-- ===== F3 =====
-- Expected:
-- | Enrollments | Graded | TotalPoints | AvgPoints |
-- | 15 | 0 | NULL | NULL |
SELECT COUNT(*) AS Enrollments,
       COUNT(GradePoints) AS Graded,
       SUM(GradePoints) AS TotalPoints,
       AVG(GradePoints) AS AvgPoints
FROM Enrollment
WHERE SectionID IN ('S1', 'S2', 'S4', 'S5', 'S7', 'S8');

-- ===== F3-fix =====
-- Expected:
-- | TotalPoints |
-- | 0 |
SELECT COALESCE(SUM(GradePoints), 0) AS TotalPoints
FROM Enrollment
WHERE SectionID IN ('S1', 'S2', 'S4', 'S5', 'S7', 'S8');
