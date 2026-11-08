-- SPDX-License-Identifier: MIT
-- Copyright (c) 2026 John Conklin
-- SQL · Lesson 7: SQL Subqueries Explained: IN, NOT IN and the NULL Trap
-- Database: campus
-- Build the database first:  sqlite3 campus.db < ../../../database/campus.sql
-- Then run:                  sqlite3 campus.db < solution.sql
-- Every query below was tested in SQLite and PostgreSQL 18.
-- Statements that are SUPPOSED to fail are commented out. Uncomment one to watch it fail.

PRAGMA foreign_keys = ON;   -- SQLite only; PostgreSQL always enforces foreign keys
.headers on
.mode column

-- ===== H1 =====
-- Expected:
-- | StudentID | SectionID | GradePoints |
-- | 10021 | S3 | 4.0 |
-- | 10023 | S6 | 4.0 |
-- | 10024 | S3 | 4.0 |
-- | 10025 | S6 | 4.0 |
SELECT StudentID, SectionID, GradePoints
FROM Enrollment
WHERE GradePoints > (SELECT AVG(GradePoints) FROM Enrollment)
ORDER BY StudentID, SectionID;

-- ===== H2 =====
-- Expected:
-- | StudentID | Name |
-- | 10021 | Ana Garcia |
-- | 10023 | Jordan Lee |
-- | 10025 | Tran Nguyen |
-- | 10027 | Priya Nair |
-- | 10028 | Leo Martinez |
-- | 10029 | Grace Okafor |
SELECT StudentID, Name
FROM Student
WHERE StudentID IN (
    SELECT e.StudentID
    FROM Enrollment AS e
    JOIN Section AS s
      ON s.SectionID = e.SectionID
    WHERE s.InstructorID = 'I3'
)
ORDER BY StudentID;

-- ===== H2-join (the join version: 9 rows, with repeats) =====
-- Expected:
-- | RowsReturned |
-- | 9 |
SELECT COUNT(*) AS RowsReturned
FROM Student AS st
JOIN Enrollment AS e
  ON e.StudentID = st.StudentID
JOIN Section AS s
  ON s.SectionID = e.SectionID
WHERE s.InstructorID = 'I3';

-- ===== H3-inner (run the inner query alone) =====
-- Expected:
-- | MentorID |
-- | NULL |
-- | I1 |
-- | I1 |
-- | NULL |
-- | I3 |
SELECT MentorID
FROM Instructor
ORDER BY InstructorID;

-- ===== H3-wrong =====
-- Expected: 0 rows.
SELECT Name
FROM Instructor
WHERE InstructorID NOT IN (SELECT MentorID FROM Instructor);

-- ===== H3 =====
-- Expected:
-- | Name |
-- | Dr. Kim |
-- | Dr. Brooks |
-- | Dr. Chen |
SELECT i.Name
FROM Instructor AS i
WHERE NOT EXISTS (
    SELECT 1
    FROM Instructor AS m
    WHERE m.MentorID = i.InstructorID
)
ORDER BY i.InstructorID;

-- ===== H3-alt =====
-- Expected:
-- | Name |
-- | Dr. Kim |
-- | Dr. Brooks |
-- | Dr. Chen |
SELECT Name
FROM Instructor
WHERE InstructorID NOT IN (
    SELECT MentorID
    FROM Instructor
    WHERE MentorID IS NOT NULL
)
ORDER BY InstructorID;
