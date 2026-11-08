-- SPDX-License-Identifier: MIT
-- Copyright (c) 2026 John Conklin
-- SQL · Lesson 4: SQL NULL, LIKE, IN and BETWEEN: Why "= NULL" Returns Nothing
-- Database: campus
-- Build the database first:  sqlite3 campus.db < ../../../database/campus.sql
-- Then run:                  sqlite3 campus.db < solution.sql
-- Every query below was tested in SQLite and PostgreSQL 18.
-- Statements that are SUPPOSED to fail are commented out. Uncomment one to watch it fail.

PRAGMA foreign_keys = ON;   -- SQLite only; PostgreSQL always enforces foreign keys
.headers on
.mode column

-- ===== E1 =====
-- Expected:
-- | StudentID | Name | Major |
-- | 10023 | Jordan Lee | Data Analytics |
-- | 10027 | Priya Nair | Mathematics |
-- | 10030 | Ben Ortiz | Data Analytics |
SELECT StudentID, Name, Major
FROM Student
WHERE Major IN ('Mathematics', 'Data Analytics')
ORDER BY StudentID;

-- ===== E2 =====
-- Expected:
-- | StudentID | Name |
-- | 10022 | Jordan Lee |
-- | 10023 | Jordan Lee |
-- | 10024 | Maya Patel |
-- | 10025 | Tran Nguyen |
SELECT StudentID, Name
FROM Student
WHERE StudentID BETWEEN 10022 AND 10025
ORDER BY StudentID;

-- ===== E3 =====
-- Expected:
-- | StudentID | Name |
-- | 10024 | Maya Patel |
-- | 10026 | Sam Whitfield |
SELECT StudentID, Name
FROM Student
WHERE Name LIKE '_a%'
ORDER BY Name;

-- ===== E4-wrong =====
-- Expected:
-- | InProgress |
-- | 0 |
SELECT COUNT(*) AS InProgress
FROM Enrollment
WHERE Grade = NULL;

-- ===== E4 =====
-- Expected:
-- | InProgress |
-- | 15 |
SELECT COUNT(*) AS InProgress
FROM Enrollment
WHERE Grade IS NULL;

-- ===== E5-wrong =====
-- Expected:
-- | NotA |
-- | 4 |
SELECT COUNT(*) AS NotA
FROM Enrollment
WHERE Grade <> 'A';

-- ===== E5 =====
-- Expected:
-- | NotA |
-- | 19 |
SELECT COUNT(*) AS NotA
FROM Enrollment
WHERE Grade <> 'A' OR Grade IS NULL;
