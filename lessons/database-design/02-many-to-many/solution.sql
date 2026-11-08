-- SPDX-License-Identifier: MIT
-- Copyright (c) 2026 John Conklin
-- Database Design · Lesson 2: Many-to-Many Relationships: The Junction Table Trick
-- Database: campus
-- Build the database first:  sqlite3 campus.db < ../../../database/campus.sql
-- Then run:                  sqlite3 campus.db < solution.sql
-- Every query below was tested in SQLite and PostgreSQL 18.
-- Statements that are SUPPOSED to fail are commented out. Uncomment one to watch it fail.

PRAGMA foreign_keys = ON;   -- SQLite only; PostgreSQL always enforces foreign keys
.headers on
.mode column

-- ===== L2-1 (Maya's sections, campus.sql) =====
-- Expected:
-- | SectionID | Term | Title |
-- | S3 | Spring 2026 | Database Systems |
-- | S4 | Fall 2026 | Database Systems |
-- | S5 | Fall 2026 | Data Structures |
SELECT s.SectionID, s.Term, c.Title
FROM Enrollment AS e
JOIN Section AS s
  ON s.SectionID = e.SectionID
JOIN Course AS c
  ON c.CourseID = s.CourseID
WHERE e.StudentID = 10024
ORDER BY s.SectionID;

-- ===== L2-2 (section S4's students) =====
-- Expected:
-- | StudentID | Name |
-- | 10024 | Maya Patel |
-- | 10025 | Tran Nguyen |
-- | 10029 | Grace Okafor |
SELECT st.StudentID, st.Name
FROM Enrollment AS e
JOIN Student AS st
  ON st.StudentID = e.StudentID
WHERE e.SectionID = 'S4'
ORDER BY st.StudentID;

-- ===== L2-3 (double enrollment) =====
-- Expected: error. SQLite: "UNIQUE constraint failed: Enrollment.StudentID, Enrollment.SectionID." PostgreSQL: "duplicate key value violates unique constraint."
-- INSERT INTO Enrollment VALUES (10024, 'S4', NULL, NULL);
