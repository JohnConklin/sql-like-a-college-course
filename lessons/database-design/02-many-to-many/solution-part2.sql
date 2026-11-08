-- SPDX-License-Identifier: MIT
-- Copyright (c) 2026 John Conklin
-- Database Design · Lesson 2: Many-to-Many Relationships: The Junction Table Trick
-- Database: empty
-- Run this file in a NEW, EMPTY database (not campus.db):
--   sqlite3 lesson.db < solution-part2.sql
-- Every query below was tested in SQLite and PostgreSQL 18.
-- Statements that are SUPPOSED to fail are commented out. Uncomment one to watch it fail.

PRAGMA foreign_keys = ON;   -- SQLite only; PostgreSQL always enforces foreign keys
.headers on
.mode column

-- ===== L2-setup (the Club example for Problem 2) =====
-- Setup: Lesson 2 clubs
CREATE TABLE Student (
    StudentID  CHAR(3)      PRIMARY KEY,
    Name       VARCHAR(40)  NOT NULL
);

CREATE TABLE Club (
    ClubID    CHAR(3)      PRIMARY KEY,
    ClubName  VARCHAR(40)  NOT NULL
);

CREATE TABLE Membership (
    StudentID  CHAR(3)      NOT NULL REFERENCES Student(StudentID),
    ClubID     CHAR(3)      NOT NULL REFERENCES Club(ClubID),
    JoinDate   DATE         NOT NULL,
    Role       VARCHAR(10)  NOT NULL,
    PRIMARY KEY (StudentID, ClubID)
);

INSERT INTO Student VALUES ('S01', 'Ana Garcia'), ('S02', 'Jordan Lee');
INSERT INTO Club VALUES ('C05', 'Chess Club'), ('C09', 'Coding Club');
INSERT INTO Membership VALUES
    ('S01', 'C05', '2026-01-20', 'President'),
    ('S01', 'C09', '2026-08-25', 'Member'),
    ('S02', 'C09', '2026-08-25', 'Treasurer');

-- ===== L2-4 (Ana's memberships) =====
-- Expected:
-- | ClubName | JoinDate | Role |
-- | Chess Club | 2026-01-20 | President |
-- | Coding Club | 2026-08-25 | Member |
SELECT c.ClubName, m.JoinDate, m.Role
FROM Membership AS m
JOIN Club AS c
  ON c.ClubID = m.ClubID
WHERE m.StudentID = 'S01'
ORDER BY c.ClubName;

-- ===== L2-5 (Ana rejoins Chess Club) =====
-- Expected: error. SQLite: "UNIQUE constraint failed." PostgreSQL: "duplicate key value violates unique constraint."
-- INSERT INTO Membership VALUES ('S01', 'C05', '2026-09-01', 'Member');
