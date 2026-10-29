-- SPDX-License-Identifier: MIT
-- Copyright (c) 2026 John Conklin
-- campus.sql : sample database for the "Learn it, then prove it" SQL series
-- Load in SQLite:  sqlite3 campus.db < campus.sql
-- (Or open DB Browser for SQLite > Execute SQL > paste > run)
-- Deliberate "trap" data is marked with  -- TRAP

PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS enrollments;
DROP TABLE IF EXISTS courses;
DROP TABLE IF EXISTS students;
DROP TABLE IF EXISTS instructors;
DROP TABLE IF EXISTS departments;
DROP TABLE IF EXISTS signup_sheet;

CREATE TABLE departments (
    dept_id     INTEGER PRIMARY KEY,
    dept_name   TEXT NOT NULL UNIQUE,
    building    TEXT
);

CREATE TABLE instructors (
    instructor_id INTEGER PRIMARY KEY,
    first_name    TEXT NOT NULL,
    last_name     TEXT NOT NULL,
    dept_id       INTEGER NOT NULL REFERENCES departments(dept_id),
    hire_year     INTEGER
);

CREATE TABLE courses (
    course_id     TEXT PRIMARY KEY,          -- e.g. 'CS101'
    title         TEXT NOT NULL,
    dept_id       INTEGER NOT NULL REFERENCES departments(dept_id),
    credits       INTEGER NOT NULL CHECK (credits BETWEEN 1 AND 5),
    instructor_id INTEGER REFERENCES instructors(instructor_id)  -- nullable: TBA
);

CREATE TABLE students (
    student_id  INTEGER PRIMARY KEY,
    first_name  TEXT NOT NULL,
    last_name   TEXT NOT NULL,
    major       TEXT,                        -- nullable: undeclared
    gpa         REAL,                        -- nullable: first-term / transfer
    enroll_year INTEGER NOT NULL,
    email       TEXT UNIQUE                  -- nullable
);

CREATE TABLE enrollments (
    student_id  INTEGER NOT NULL REFERENCES students(student_id),
    course_id   TEXT    NOT NULL REFERENCES courses(course_id),
    term        TEXT    NOT NULL,            -- '2026FA', '2026SP'
    grade       TEXT,                        -- nullable: in progress
    PRIMARY KEY (student_id, course_id, term)
);

INSERT INTO departments VALUES
 (1, 'Computer Science', 'Turing Hall'),
 (2, 'Information Systems', 'Codd Center'),
 (3, 'Mathematics', 'Euler Hall'),
 (4, 'Business', NULL);                                   -- TRAP: NULL building

INSERT INTO instructors VALUES
 (1, 'Grace',  'Hopper',   1, 2012),
 (2, 'Edgar',  'Codd',     2, 2015),
 (3, 'Ada',    'Lovelace', 1, 2019),
 (4, 'Alan',   'Turing',   3, 2010),
 (5, 'Peter',  'Chen',     2, 2021),
 (6, 'Katherine','Johnson',3, 2023);                      -- TRAP: teaches nothing

INSERT INTO courses VALUES
 ('CS101',  'Intro to Programming',     1, 3, 1),
 ('CS201',  'Data Structures',          1, 4, 3),
 ('IS210',  'Database Design',          2, 3, 2),
 ('IS310',  'Advanced SQL',             2, 3, 2),
 ('IS320',  'Data Modeling',            2, 3, 5),
 ('MATH150','Discrete Math',            3, 4, 4),
 ('MATH250','Statistics',               3, 3, 4),
 ('BUS100', 'Intro to Business',        4, 3, NULL),      -- TRAP: no instructor
 ('CS350',  'Web Databases',            1, 3, 3),
 ('IS400',  'Data Warehousing',         2, 4, 5);         -- TRAP: no enrollments

INSERT INTO students VALUES
 (1,  'Maria',   'Lopez',    'Information Systems', 3.62, 2024, 'mlopez@campus.edu'),
 (2,  'James',   'Carter',   'Computer Science',    2.95, 2023, 'jcarter@campus.edu'),
 (3,  'Ann',     'Nguyen',   'Computer Science',    3.88, 2025, 'anguyen@campus.edu'),
 (4,  'Anna',    'Smith',    'Mathematics',         3.10, 2024, 'asmith@campus.edu'),   -- TRAP: LIKE 'Ann%'
 (5,  'Devon',   'Brooks',   'Information Systems', 2.40, 2022, NULL),                  -- TRAP: NULL email
 (6,  'Priya',   'Patel',    'Computer Science',    3.71, 2023, 'ppatel@campus.edu'),
 (7,  'Luis',    'Garcia',   NULL,                  3.05, 2025, 'lgarcia@campus.edu'),  -- TRAP: undeclared
 (8,  'Hannah',  'Kim',      'Business',            3.45, 2024, 'hkim@campus.edu'),
 (9,  'Omar',    'Haddad',   'Information Systems', NULL, 2026, 'ohaddad@campus.edu'),  -- TRAP: NULL gpa
 (10, 'Chloe',   'Martin',   'Mathematics',         3.95, 2022, 'cmartin@campus.edu'),
 (11, 'Ethan',   'Wright',   'Computer Science',    2.10, 2023, 'ewright@campus.edu'),
 (12, 'Sofia',   'Rossi',    'Business',            3.00, 2025, NULL),                  -- TRAP: NULL email
 (13, 'Noah',    'Bennett',  'Information Systems', 3.30, 2024, 'nbennett@campus.edu'),
 (14, 'Zoe',     'Adams',    NULL,                  NULL, 2026, 'zadams@campus.edu'),   -- TRAP: no enrollments
 (15, 'Marcus',  'Lee',      'Computer Science',    3.50, 2024, 'mlee@campus.edu');

INSERT INTO enrollments VALUES
 (1,'IS210','2026SP','A'),  (1,'IS310','2026FA',NULL), (1,'MATH250','2026SP','B'),
 (2,'CS101','2026SP','C'),  (2,'CS201','2026FA',NULL), (2,'IS210','2026SP','B'),
 (3,'CS101','2026SP','A'),  (3,'CS201','2026FA',NULL), (3,'MATH150','2026SP','A'),
 (4,'MATH150','2026SP','B'),(4,'MATH250','2026FA',NULL),
 (5,'IS210','2026SP','D'),  (5,'IS210','2026FA',NULL),                                 -- TRAP: retake
 (6,'CS101','2026SP','A'),  (6,'CS201','2026FA',NULL), (6,'CS350','2026FA',NULL), (6,'IS210','2026SP','A'),
 (7,'CS101','2026FA',NULL), (7,'BUS100','2026FA',NULL),
 (8,'BUS100','2026SP','B'), (8,'IS210','2026FA',NULL),
 (9,'IS210','2026FA',NULL), (9,'CS101','2026FA',NULL),
 (10,'MATH150','2026SP','A'),(10,'MATH250','2026SP','A'),(10,'CS201','2026FA',NULL),
 (11,'CS101','2026SP','F'), (11,'CS101','2026FA',NULL),                                -- TRAP: retake
 (12,'BUS100','2026SP','C'),(12,'MATH250','2026FA',NULL),
 (13,'IS210','2026SP','B'), (13,'IS310','2026FA',NULL), (13,'IS320','2026FA',NULL),
 (15,'CS101','2026SP','B'), (15,'CS350','2026FA',NULL), (15,'IS210','2026SP','A');

-- Lesson 10 (normalization): a deliberately BAD, unnormalized table
CREATE TABLE signup_sheet (
    student_name   TEXT,
    student_email  TEXT,
    major          TEXT,
    courses        TEXT,   -- comma-separated list  -> violates 1NF
    instructor     TEXT,   -- depends on the course, not the student
    dept_building  TEXT    -- depends on the department -> transitive dependency
);
INSERT INTO signup_sheet VALUES
 ('Maria Lopez',  'mlopez@campus.edu',  'Information Systems', 'IS210, IS310', 'Codd', 'Codd Center'),
 ('James Carter', 'jcarter@campus.edu', 'Computer Science',    'CS101, CS201, IS210', 'Hopper, Lovelace, Codd', 'Turing Hall'),
 ('Maria Lopez',  'maria.l@campus.edu', 'Info Systems',        'MATH250', 'Turing', 'Euler Hall');  -- update anomaly
