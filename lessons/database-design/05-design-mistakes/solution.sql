-- SPDX-License-Identifier: MIT
-- Copyright (c) 2026 John Conklin
-- Database Design · Lesson 5: 7 Database Design Mistakes I See in Student Projects
-- Database: empty
-- Run this file in a NEW, EMPTY database (not campus.db):
--   sqlite3 lesson.db < solution.sql
-- Every query below was tested in SQLite and PostgreSQL 18.
-- Statements that are SUPPOSED to fail are commented out. Uncomment one to watch it fail.

PRAGMA foreign_keys = ON;   -- SQLite only; PostgreSQL always enforces foreign keys
.headers on
.mode column

-- ===== L5-setup (run in a new, empty database) =====
-- Setup: Lesson 5
CREATE TABLE StudentByName (
    Name   VARCHAR(40)  PRIMARY KEY,
    Major  VARCHAR(40)  NOT NULL
);
INSERT INTO StudentByName VALUES ('Jordan Lee', 'Computer Science');

CREATE TABLE StudentList (
    StudentID  INTEGER       PRIMARY KEY,
    Name       VARCHAR(40)   NOT NULL,
    Courses    VARCHAR(100)
);
INSERT INTO StudentList VALUES
    (10021, 'Ana Garcia', 'CS101, IS200'),
    (10022, 'Jordan Lee', 'CS101'),
    (10024, 'Maya Patel', 'CS250');

CREATE TABLE StudentCourse (
    StudentID  INTEGER  NOT NULL,
    CourseID   CHAR(5)  NOT NULL,
    PRIMARY KEY (StudentID, CourseID)
);
INSERT INTO StudentCourse VALUES
    (10021, 'CS101'), (10021, 'IS200'), (10022, 'CS101'), (10024, 'CS250');

CREATE TABLE StoredTotal (
    StudentID     INTEGER  PRIMARY KEY,
    TotalCredits  INTEGER  NOT NULL
);
INSERT INTO StoredTotal VALUES (10021, 6);

CREATE TABLE Taking (
    StudentID  INTEGER  NOT NULL,
    CourseID   CHAR(5)  NOT NULL,
    Credits    INTEGER  NOT NULL,
    PRIMARY KEY (StudentID, CourseID)
);
INSERT INTO Taking VALUES (10021, 'CS101', 3), (10021, 'IS200', 3);

CREATE TABLE TextDates (DueDate VARCHAR(10));
INSERT INTO TextDates VALUES ('11/15/2025'), ('12/01/2025'), ('02/01/2026');

CREATE TABLE RealDates (DueDate DATE);
INSERT INTO RealDates VALUES ('2025-11-15'), ('2025-12-01'), ('2026-02-01');

-- ===== L5-1 (Mistake 1: the second Jordan Lee) =====
-- Expected: error in both databases (duplicate primary key). A real student can't be saved.
-- INSERT INTO StudentByName VALUES ('Jordan Lee', 'Data Analytics');

-- ===== L5-2-wrong (Mistake 2: who takes CS101?) =====
-- Expected:
-- | StudentID | Name |
-- | 10022 | Jordan Lee |
SELECT StudentID, Name
FROM StudentList
WHERE Courses = 'CS101';

-- ===== L5-2 (the fix: one row per course) =====
-- Expected:
-- | StudentID |
-- | 10021 |
-- | 10022 |
SELECT StudentID
FROM StudentCourse
WHERE CourseID = 'CS101'
ORDER BY StudentID;

-- ===== L5-6 (Mistake 6: the stored total goes stale) =====
-- Expected:
-- | Stored | Actual |
-- | 6 | 10 |
INSERT INTO Taking VALUES (10021, 'CS310', 4);

SELECT st.TotalCredits AS Stored,
       (SELECT SUM(Credits) FROM Taking WHERE StudentID = 10021) AS Actual
FROM StoredTotal AS st
WHERE st.StudentID = 10021;

-- ===== L5-7a (Mistake 7: a ZIP code as a number) =====
-- Expected:
-- | ZipAsNumber |
-- | 2134 |
SELECT CAST('02134' AS INTEGER) AS ZipAsNumber;

-- ===== L5-7b (dates stored as text) =====
-- Expected:
-- | DueDate |
-- | 02/01/2026 |
-- | 11/15/2025 |
-- | 12/01/2025 |
SELECT DueDate
FROM TextDates
ORDER BY DueDate;

-- ===== L5-7c (dates stored as DATE) =====
-- Expected:
-- | DueDate |
-- | 2025-11-15 |
-- | 2025-12-01 |
-- | 2026-02-01 |
SELECT DueDate
FROM RealDates
ORDER BY DueDate;
