-- SPDX-License-Identifier: MIT
-- Copyright (c) 2026 John Conklin
-- Database Design · Lesson 3: Database Normalization Explained: 1NF to 3NF With One Messy Table
-- Database: empty
-- Run this file in a NEW, EMPTY database (not campus.db):
--   sqlite3 lesson.db < solution.sql
-- Every query below was tested in SQLite and PostgreSQL 18.
-- Statements that are SUPPOSED to fail are commented out. Uncomment one to watch it fail.

PRAGMA foreign_keys = ON;   -- SQLite only; PostgreSQL always enforces foreign keys
.headers on
.mode column

-- ===== L3-setup (run in a new, empty database) =====
-- Setup: Lesson 3
-- The 1NF table
CREATE TABLE Registration1NF (
    StudentID     INTEGER      NOT NULL,
    StudentName   VARCHAR(40)  NOT NULL,
    CourseID      CHAR(5)      NOT NULL,
    Title         VARCHAR(40)  NOT NULL,
    InstructorID  CHAR(2)      NOT NULL,
    Office        VARCHAR(10)  NOT NULL,
    Grade         CHAR(1)      NOT NULL,
    PRIMARY KEY (StudentID, CourseID)
);

INSERT INTO Registration1NF VALUES
    (10021, 'Ana Garcia', 'CS101', 'Intro to Programming', 'I1', 'ENG 210', 'A'),
    (10021, 'Ana Garcia', 'IS200', 'Web Development',      'I3', 'BUS 118', 'B'),
    (10022, 'Jordan Lee', 'CS101', 'Intro to Programming', 'I1', 'ENG 210', 'B'),
    (10022, 'Jordan Lee', 'CS250', 'Database Systems',     'I2', 'ENG 305', 'A'),
    (10024, 'Maya Patel', 'CS250', 'Database Systems',     'I2', 'ENG 305', 'C');

-- The 3NF tables
CREATE TABLE Instructor (
    InstructorID  CHAR(2)      PRIMARY KEY,
    Office        VARCHAR(10)  NOT NULL
);

CREATE TABLE Student (
    StudentID    INTEGER      PRIMARY KEY,
    StudentName  VARCHAR(40)  NOT NULL
);

CREATE TABLE Course (
    CourseID      CHAR(5)      PRIMARY KEY,
    Title         VARCHAR(40)  NOT NULL,
    InstructorID  CHAR(2)      NOT NULL REFERENCES Instructor(InstructorID)
);

CREATE TABLE Registration (
    StudentID  INTEGER  NOT NULL REFERENCES Student(StudentID),
    CourseID   CHAR(5)  NOT NULL REFERENCES Course(CourseID),
    Grade      CHAR(1)  NOT NULL,
    PRIMARY KEY (StudentID, CourseID)
);

INSERT INTO Instructor VALUES ('I1', 'ENG 210'), ('I2', 'ENG 305'), ('I3', 'BUS 118');
INSERT INTO Student VALUES (10021, 'Ana Garcia'), (10022, 'Jordan Lee'), (10024, 'Maya Patel');
INSERT INTO Course VALUES
    ('CS101', 'Intro to Programming', 'I1'),
    ('CS250', 'Database Systems',     'I2'),
    ('IS200', 'Web Development',      'I3');
INSERT INTO Registration VALUES
    (10021, 'CS101', 'A'), (10021, 'IS200', 'B'),
    (10022, 'CS101', 'B'), (10022, 'CS250', 'A'),
    (10024, 'CS250', 'C');

-- ===== L3-1 (update anomaly: rows to change if Dr. Shah moves offices) =====
-- Expected:
-- | RowsIn1NF | RowsIn3NF |
-- | 2 | 1 |
SELECT
  (SELECT COUNT(*) FROM Registration1NF WHERE InstructorID = 'I1') AS RowsIn1NF,
  (SELECT COUNT(*) FROM Instructor WHERE InstructorID = 'I1') AS RowsIn3NF;

-- ===== L3-2 (insert anomaly: a new course with no students yet) =====
-- Expected: error in both databases, because StudentID can't be NULL. In the 3NF design, `INSERT INTO Course VALUES ('CS310', 'Data Structures', 'I2');` works, with no student needed.
-- INSERT INTO Registration1NF
-- VALUES (NULL, 'TBA', 'CS310', 'Data Structures', 'I2', 'ENG 305', 'A');

-- ===== L3-3 (join it back) =====
-- Expected:
-- | StudentID | StudentName | CourseID | Title | InstructorID | Office | Grade |
-- | 10021 | Ana Garcia | CS101 | Intro to Programming | I1 | ENG 210 | A |
-- | 10021 | Ana Garcia | IS200 | Web Development | I3 | BUS 118 | B |
-- | 10022 | Jordan Lee | CS101 | Intro to Programming | I1 | ENG 210 | B |
-- | 10022 | Jordan Lee | CS250 | Database Systems | I2 | ENG 305 | A |
-- | 10024 | Maya Patel | CS250 | Database Systems | I2 | ENG 305 | C |
SELECT r.StudentID, s.StudentName, r.CourseID, c.Title,
       c.InstructorID, i.Office, r.Grade
FROM Registration AS r
JOIN Student AS s ON s.StudentID = r.StudentID
JOIN Course AS c ON c.CourseID = r.CourseID
JOIN Instructor AS i ON i.InstructorID = c.InstructorID
ORDER BY r.StudentID, r.CourseID;

-- ===== L3-4 (lossless check: should return 0 rows) =====
-- Expected: 0 rows. Swapping the two halves also returns 0 rows, so nothing is missing and nothing is extra.
SELECT StudentID, StudentName, CourseID, Title, InstructorID, Office, Grade
FROM Registration1NF
EXCEPT
SELECT r.StudentID, s.StudentName, r.CourseID, c.Title,
       c.InstructorID, i.Office, r.Grade
FROM Registration AS r
JOIN Student AS s ON s.StudentID = r.StudentID
JOIN Course AS c ON c.CourseID = r.CourseID
JOIN Instructor AS i ON i.InstructorID = c.InstructorID;
