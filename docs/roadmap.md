# SQL Series Roadmap · Lessons 1–10

**Playlist:** SQL Like a College Course (Learn It, Then Prove It)
**Cadence:** 1 lesson every 2 weeks, published on Thursdays
**Sample database:** `database/campus.sql`, one college database used in every lesson (departments, instructors, courses, students, enrollments)
**Answer key:** `solutions/answer_key.sql`. Every solution below was run against `campus.db` in SQLite 3.53, and the results match what's listed here.

---

## Why this order

1. **Lessons 1–5: one table.** Viewers learn to read, filter, count and group before they have to deal with relationships. This covers most of a first SQL exam.
2. **Lesson 6: design.** This is the "database design" half of the niche. It also prepares viewers for joins, because they understand keys first.
3. **Lessons 7–9: multiple tables.** Joins and subqueries, the most-searched and most-failed exam topics.
4. **Lesson 10: normalization.** The design capstone, and the bridge to the next series (Python + SQLite).

Every lesson has a **trap problem** built on deliberate "dirty" data in the sample database: NULLs, a student with no enrollments, a course with no instructor, retakes. This is the "explain the why" angle. Viewers see why the obvious answer is wrong, not only what the right one is.

## Publish calendar

| # | Lesson | Publish date | Season note |
|---|---|---|---|
| 1 | Tables, keys and SELECT | Thu Nov 12, 2026 | |
| 2 | WHERE and ORDER BY | Thu Nov 26 | Thanksgiving: schedule it ahead of time |
| 3 | IN, BETWEEN, LIKE and NULL | Thu Dec 10 | Fall finals: push Shorts hard |
| 4 | COUNT, SUM, AVG, MIN, MAX | Thu Dec 24 | Holiday: bank this one early, or skip and shift |
| 5 | GROUP BY and HAVING | Thu Jan 7, 2027 | Spring term starts: new students searching |
| 6 | Keys and relationships (design) | Thu Jan 21 | |
| 7 | INNER JOIN | Thu Feb 4 | |
| 8 | LEFT JOIN | Thu Feb 18 | |
| 9 | Subqueries | Thu Mar 4 | Spring midterms |
| 10 | Normalization (1NF to 3NF) | Thu Mar 18 | |

---

## Lesson 1 · Tables, Keys and SELECT

- **YouTube title:** SQL SELECT Explained: Read Any Database Like an Exam Question
- **Search phrase:** "sql select tutorial for beginners"
- **Learn it (why):** A table is a set of rows about one kind of thing. The primary key exists so the database can tell two rows apart. SELECT chooses columns; it doesn't change data.
- **Misconception:** "SELECT * is fine." It hides what you actually need, and in exams it often costs points.
- **Prove it**
  - **P1 (warm-up):** List every student's first name, last name and major. → 15 rows. Two show a blank major: Luis Garcia and Zoe Adams. Point this out as a preview of NULL.
  - **P2 (exam):** Show each course's ID, title and credits. → 10 rows.
  - **P3 (trap):** Insert a new student with `student_id = 1`. → Error: `UNIQUE constraint failed: students.student_id`. That error is the primary key doing its job.
- **Shorts:** S1 "What happens if two rows have the same ID?" · S2 "Stop using SELECT *" · S3 "Primary key in 45 seconds"
- **Thumbnail text:** READ IT LIKE AN EXAM

## Lesson 2 · WHERE and ORDER BY

- **YouTube title:** SQL WHERE and ORDER BY: The AND/OR Mistake That Costs Exam Points
- **Search phrase:** "sql where clause and or"
- **Learn it (why):** WHERE filters rows before you see them. ORDER BY only sorts the output. AND is evaluated before OR, just like multiplication comes before addition.
- **Misconception:** SQL reads conditions left to right.
- **Prove it**
  - **P1:** Students with a GPA of 3.5 or higher, highest first. → 5 rows: Chloe 3.95, Ann 3.88, Priya 3.71, Maria 3.62, Marcus 3.50.
  - **P2:** Computer Science students who enrolled in 2023 or earlier, sorted by last name. → James Carter, Priya Patel, Ethan Wright.
  - **P3 (trap):** CS or Math students with a GPA above 3.5. Without parentheses you get 6 rows: every CS student, including GPAs of 2.95 and 2.10. With `(major = 'Computer Science' OR major = 'Mathematics') AND gpa > 3.5` you get the correct 3 rows: Ann, Priya, Chloe.
- **Shorts:** S1 "This query has a bug. Can you spot it?" (the AND/OR one) · S2 "Parentheses change everything" · S3 "WHERE vs ORDER BY in 45 seconds"
- **Thumbnail text:** 6 ROWS? SHOULD BE 3

## Lesson 3 · IN, BETWEEN, LIKE and NULL

- **YouTube title:** SQL NULL, LIKE, IN and BETWEEN: Why "= NULL" Returns Nothing
- **Search phrase:** "sql is null vs = null"
- **Learn it (why):** NULL means "unknown," not empty or zero. Comparing anything to unknown gives unknown, so `= NULL` never matches. BETWEEN includes both ends of the range. LIKE patterns match more than you expect.
- **Misconception:** `WHERE email = NULL` finds missing emails.
- **Prove it**
  - **P1:** IS or Business students with a GPA between 3.0 and 3.5. → Hannah Kim, Sofia Rossi (exactly 3.00, so it's included because BETWEEN is inclusive) and Noah Bennett.
  - **P2 (pattern):** Find students named Ann using `LIKE 'Ann%'`. → It returns both Ann and Anna. Discuss when to use `=` instead.
  - **P3 (trap):** Students with no email on file. `= NULL` returns 0 rows. `IS NULL` returns Devon Brooks and Sofia Rossi.
- **Shorts:** S1 "Why does this return zero rows?" · S2 "LIKE caught the wrong student" · S3 "NULL explained in 45 seconds"
- **Thumbnail text:** = NULL IS WRONG

## Lesson 4 · Aggregate Functions

- **YouTube title:** SQL COUNT, SUM, AVG Explained: COUNT(*) vs COUNT(column)
- **Search phrase:** "count(*) vs count(column)"
- **Learn it (why):** Aggregate functions collapse many rows into one answer. Every aggregate except COUNT(*) skips NULLs, and that changes your result without any warning.
- **Misconception:** COUNT(*) and COUNT(email) give the same number.
- **Prove it**
  - **P1:** Total students and the average GPA. → 15 students, average GPA 3.23. Point out that the average uses only 13 students, because 2 have no GPA.
  - **P2:** The earliest and most recent instructor hire years. → 2010 and 2023.
  - **P3 (trap):** In one query, show COUNT(*), COUNT(email), COUNT(gpa) and COUNT(DISTINCT major). → 15, 13, 13, 4. Ask viewers to explain each difference.
- **Shorts:** S1 "Why are these counts different?" · S2 "AVG ignores NULL, and your exam knows it" · S3 "5 aggregate functions in 45 seconds"
- **Thumbnail text:** 15 OR 13?

## Lesson 5 · GROUP BY and HAVING

- **YouTube title:** SQL GROUP BY and HAVING: WHERE vs HAVING Finally Explained
- **Search phrase:** "where vs having sql"
- **Learn it (why):** GROUP BY makes one row per group. WHERE filters rows before grouping; HAVING filters groups after. That's why aggregates can't go in WHERE.
- **Misconception:** HAVING is just another WHERE.
- **Prove it**
  - **P1:** Number of students per major, largest first. → CS 5, IS 4, Math 2, Business 2, and a NULL group of 2. NULLs form their own group.
  - **P2:** Fall 2026 courses with 2 or more enrollments. → CS201 4; IS210, CS101 3; MATH250, IS310, CS350 2.
  - **P3 (trap):** Majors with an average GPA above 3.3. `WHERE AVG(gpa) > 3.3` gives the error `misuse of aggregate: AVG()`. The HAVING version returns Mathematics only (3.53). Also exclude the NULL major on purpose.
- **Shorts:** S1 "This query crashes. Why?" · S2 "WHERE vs HAVING in one picture" · S3 "The NULL group nobody expects"
- **Thumbnail text:** WHERE ≠ HAVING

## Lesson 6 · Keys and Relationships (Design)

- **YouTube title:** Primary Keys, Foreign Keys and Relationships: Database Design Explained
- **Search phrase:** "primary key vs foreign key"
- **Learn it (why):** A foreign key is a promise that a value points to a real row in another table. Relationships can be one-to-many (a department has many instructors) or many-to-many (students and courses, through a junction table). Walk through the `CREATE TABLE` statements and draw the ERD.
- **Misconception:** A many-to-many relationship can be stored in one column.
- **Prove it**
  - **P1 (design):** Draw the ERD for the 5 tables and label each relationship 1:M or M:N. Answer: enrollments is the junction table between students and courses.
  - **P2 (design):** Why is the enrollments primary key `(student_id, course_id, term)` and not `(student_id, course_id)`? Show the retakes: Devon took IS210 in both terms, and Ethan took CS101 in both terms.
  - **P3 (trap):** Enroll student 99, who doesn't exist. → `FOREIGN KEY constraint failed`. Note that SQLite only enforces this after `PRAGMA foreign_keys = ON`. That's a real gotcha worth showing.
- **Shorts:** S1 "Why does this INSERT fail?" · S2 "Why term is part of the key" (retakes) · S3 "Primary key vs foreign key in 45 seconds"
- **Thumbnail text:** THE KEY TO JOINS
- **Note:** This is the lesson most directly tied to "database design," so it's a good one to pin on the channel homepage.

## Lesson 7 · INNER JOIN

- **YouTube title:** SQL INNER JOIN Explained Step by Step (With Exam Problems)
- **Search phrase:** "sql inner join explained"
- **Learn it (why):** A join matches rows from two tables wherever the keys are equal. INNER JOIN keeps only rows that have a match on both sides. Build the result row by row on screen.
- **Misconception:** JOIN returns every row from both tables.
- **Prove it**
  - **P1:** Each course with its instructor's last name. → 9 rows.
  - **P2 (3-table join):** Students who earned an A in Spring 2026, with the course title. → 8 rows (Marcus, Maria, Chloe ×2, Ann ×2, Priya ×2).
  - **P3 (trap):** "There are 10 courses. Why did P1 return only 9?" → BUS100 has no instructor (NULL), so INNER JOIN drops it silently. This sets up Lesson 8.
- **Shorts:** S1 "10 courses in, 9 out. Where did one go?" · S2 "INNER JOIN in 45 seconds" · S3 "Joining 3 tables without panicking"
- **Thumbnail text:** WHERE'S ROW 10?

## Lesson 8 · LEFT JOIN

- **YouTube title:** SQL LEFT JOIN: The WHERE Clause Mistake That Breaks It
- **Search phrase:** "left join vs inner join"
- **Learn it (why):** LEFT JOIN keeps every row from the left table and fills in NULL where there's no match. That makes it the tool for questions like "find what's missing."
- **Misconception:** A filter in WHERE and a filter in ON do the same thing.
- **Prove it**
  - **P1:** Students who have never enrolled in anything. → Zoe Adams. The pattern is LEFT JOIN plus `IS NULL`.
  - **P2:** Enrollment count for every course, including courses with zero. → IS400 shows 0, and IS210 is highest at 9. Use `COUNT(e.student_id)`, not `COUNT(*)`. This ties back to Lesson 4.
  - **P3 (trap):** Fall 2026 enrollment for every course. Putting `e.term = '2026FA'` in WHERE drops IS400 and MATH150, because WHERE runs after the join and removes the NULL rows. Moving the condition into ON returns all 10 courses, with zeros.
- **Shorts:** S1 "Your LEFT JOIN is secretly an INNER JOIN" · S2 "Find what's missing with LEFT JOIN" · S3 "LEFT vs INNER in 45 seconds"
- **Thumbnail text:** LEFT JOIN BROKEN?

## Lesson 9 · Subqueries

- **YouTube title:** SQL Subqueries Explained: IN, NOT IN and the NULL Trap
- **Search phrase:** "sql subquery tutorial"
- **Learn it (why):** A subquery is a question inside a question. It can return one value (compare to the average) or a list (match against IN). NOT IN fails when the list contains a NULL.
- **Misconception:** NOT IN and NOT EXISTS are interchangeable.
- **Prove it**
  - **P1:** Students with a GPA above the average. → 7 students, from Chloe (3.95) down to Noah (3.30).
  - **P2:** Students taking any Information Systems course. → 8 students. Show the same answer written as a join for comparison.
  - **P3 (trap):** Instructors who teach no courses. `NOT IN (SELECT instructor_id FROM courses)` returns 0 rows, because BUS100's instructor is NULL. `NOT EXISTS` correctly returns Katherine Johnson.
- **Shorts:** S1 "This query should return 1 row. It returns 0." · S2 "NOT IN vs NOT EXISTS" · S3 "Subqueries in 45 seconds"
- **Thumbnail text:** NOT IN = NOTHING?

## Lesson 10 · Normalization (1NF to 3NF)

- **YouTube title:** Database Normalization Explained: 1NF, 2NF, 3NF With One Messy Table
- **Search phrase:** "database normalization 1nf 2nf 3nf"
- **Learn it (why):** Normalization removes repeated facts so each fact is stored in one place. That prevents insert, update and delete anomalies. Use `signup_sheet` as the "before" table and the 5 campus tables as the "after."
- **Misconception:** Normalization exists only to save disk space.
- **Prove it**
  - **P1 (1NF):** What's wrong with the `courses` column? → It holds a comma-separated list. Split it into one row per student per course.
  - **P2 (2NF/3NF):** Instructor depends on the course, and building depends on the department, not on the student. Move each into its own table. → The result is the existing campus design.
  - **P3 (trap / anomaly):** Run the GROUP BY query on `signup_sheet`. → Maria Lopez has 2 emails and 2 spellings of her major. That's an update anomaly, shown with real query output.
- **Shorts:** S1 "This table has 3 design mistakes. Find them." · S2 "Update anomaly in 30 seconds" · S3 "1NF, 2NF, 3NF in 45 seconds"
- **Thumbnail text:** FIX THIS TABLE
- **Series bridge:** End with a teaser: "Next series: we take this exact database into Python with SQLite."

---

## Reuse across lessons

- **Description boilerplate:** "Download the sample database (campus.sql) to follow along: [GitHub/Drive link]." Use the same link in every video, so viewers who download it once are more likely to stay for the rest of the series.
- **Callbacks:** Lessons 7–9 deliberately reuse traps from Lessons 3–4 (NULL, COUNT). Add a card to the earlier video each time. Watch time across the series compounds.
- **Bonus comment problem:** End each lesson with one unsolved problem against `campus.db`. Answer it in the pinned comment a week later, or as a Short.
- **Future series hooks:** Lesson 4 → window functions. Lesson 8 → RIGHT/FULL joins. Lesson 10 → Python + SQLite.

---

© 2026 John Conklin. Text licensed under [CC BY 4.0](https://creativecommons.org/licenses/by/4.0/). SQL code licensed under the [MIT License](../LICENSE).
