-- SPDX-License-Identifier: MIT
-- Copyright (c) 2026 John Conklin
-- campus.sql
-- The campus sample database used in every lesson and video in this series,
-- and in the SQL Joins & GROUP BY Practice Pack.
-- (c) 2026 John Conklin. Standard SQL; tested in SQLite 3.39+ and PostgreSQL 18.
-- Load it in SQLite:   sqlite3 campus.db < campus.sql
-- Or in Python:        sqlite3.connect("campus.db").executescript(open("campus.sql").read())
-- Load it in PostgreSQL: createdb campus && psql -d campus -f campus.sql

-- Optional, SQLite only: run  PRAGMA foreign_keys = ON;  first if you want
-- SQLite to enforce the foreign keys. PostgreSQL always enforces them.

DROP TABLE IF EXISTS Enrollment;
DROP TABLE IF EXISTS Section;
DROP TABLE IF EXISTS Student;
DROP TABLE IF EXISTS Course;
DROP TABLE IF EXISTS Instructor;
DROP TABLE IF EXISTS Department;

CREATE TABLE Department (
    DeptID    CHAR(3)      PRIMARY KEY,
    DeptName  VARCHAR(40)  NOT NULL UNIQUE
);

CREATE TABLE Instructor (
    InstructorID  CHAR(2)      PRIMARY KEY,
    Name          VARCHAR(40)  NOT NULL,
    DeptID        CHAR(3)      NOT NULL REFERENCES Department(DeptID),
    MentorID      CHAR(2)      NULL REFERENCES Instructor(InstructorID)
);

CREATE TABLE Course (
    CourseID  CHAR(5)      PRIMARY KEY,
    Title     VARCHAR(40)  NOT NULL,
    Credits   INTEGER      NOT NULL CHECK (Credits BETWEEN 1 AND 6),
    DeptID    CHAR(3)      NOT NULL REFERENCES Department(DeptID)
);

CREATE TABLE Section (
    SectionID     CHAR(2)      PRIMARY KEY,
    CourseID      CHAR(5)      NOT NULL REFERENCES Course(CourseID),
    Term          VARCHAR(12)  NOT NULL,
    InstructorID  CHAR(2)      NULL REFERENCES Instructor(InstructorID)  -- NULL = instructor TBA
);

CREATE TABLE Student (
    StudentID  INTEGER      PRIMARY KEY,
    Name       VARCHAR(40)  NOT NULL,
    Major      VARCHAR(40)  NOT NULL
);

CREATE TABLE Enrollment (
    StudentID    INTEGER       NOT NULL REFERENCES Student(StudentID),
    SectionID    CHAR(2)       NOT NULL REFERENCES Section(SectionID),
    Grade        CHAR(1)       NULL,   -- NULL = term still in progress
    GradePoints  DECIMAL(2,1)  NULL,
    PRIMARY KEY (StudentID, SectionID)
);

INSERT INTO Department VALUES
    ('D10', 'Computer Science'),
    ('D20', 'Information Systems'),
    ('D30', 'Mathematics'),
    ('D40', 'Data Science');           -- no courses yet

INSERT INTO Instructor VALUES
    ('I1', 'Dr. Shah',   'D10', NULL), -- no mentor
    ('I2', 'Dr. Kim',    'D10', 'I1'),
    ('I3', 'Dr. Ortiz',  'D20', 'I1'),
    ('I4', 'Dr. Brooks', 'D30', NULL), -- no mentor
    ('I5', 'Dr. Chen',   'D20', 'I3'); -- teaches no sections

INSERT INTO Course VALUES
    ('CS101', 'Intro to Programming', 3, 'D10'),
    ('CS250', 'Database Systems',     3, 'D10'),
    ('CS310', 'Data Structures',      4, 'D10'),
    ('IS200', 'Web Development',      3, 'D20'),
    ('IS340', 'Data Analytics',       3, 'D20'),
    ('MA210', 'Discrete Math',        4, 'D30'); -- never offered

INSERT INTO Section VALUES
    ('S1', 'CS101', 'Fall 2026',   'I1'),
    ('S2', 'CS101', 'Fall 2026',   'I2'),  -- second section of the same course
    ('S3', 'CS250', 'Spring 2026', 'I1'),
    ('S4', 'CS250', 'Fall 2026',   'I2'),
    ('S5', 'CS310', 'Fall 2026',   NULL),  -- instructor TBA
    ('S6', 'IS200', 'Spring 2026', 'I3'),
    ('S7', 'IS340', 'Fall 2026',   'I3'),
    ('S8', 'IS200', 'Fall 2026',   'I3');

INSERT INTO Student VALUES
    (10021, 'Ana Garcia',    'Information Systems'),
    (10022, 'Jordan Lee',    'Computer Science'),
    (10023, 'Jordan Lee',    'Data Analytics'),   -- same name, different student
    (10024, 'Maya Patel',    'Computer Science'),
    (10025, 'Tran Nguyen',   'Information Systems'),
    (10026, 'Sam Whitfield', 'Computer Science'),
    (10027, 'Priya Nair',    'Mathematics'),
    (10028, 'Leo Martinez',  'Information Systems'),
    (10029, 'Grace Okafor',  'Computer Science'),
    (10030, 'Ben Ortiz',     'Data Analytics');   -- no enrollments

-- Spring 2026 is graded. Fall 2026 is in progress, so Grade is NULL.
INSERT INTO Enrollment VALUES
    (10021, 'S3', 'A', 4.0),
    (10022, 'S3', 'B', 3.0),
    (10024, 'S3', 'A', 4.0),
    (10026, 'S3', 'C', 2.0),
    (10021, 'S6', 'B', 3.0),
    (10023, 'S6', 'A', 4.0),
    (10025, 'S6', 'A', 4.0),
    (10028, 'S6', 'B', 3.0),
    (10023, 'S1', NULL, NULL),
    (10026, 'S1', NULL, NULL),
    (10029, 'S1', NULL, NULL),
    (10022, 'S2', NULL, NULL),
    (10027, 'S2', NULL, NULL),
    (10024, 'S4', NULL, NULL),
    (10025, 'S4', NULL, NULL),
    (10029, 'S4', NULL, NULL),
    (10022, 'S5', NULL, NULL),
    (10024, 'S5', NULL, NULL),
    (10021, 'S7', NULL, NULL),
    (10023, 'S7', NULL, NULL),
    (10028, 'S7', NULL, NULL),
    (10027, 'S8', NULL, NULL),
    (10029, 'S8', NULL, NULL);
