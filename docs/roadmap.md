# Series Roadmap

**Playlists:** Database Design · SQL Like a College Course (Learn It, Then Prove It)
**Cadence:** one long lesson a week, published on **Tuesdays**, with a Short on Fridays.
**Sample database:** [`database/campus.sql`](../database/campus.sql), the same college database in every lesson, video and free practice sample.
**Testing:** every query in every lesson was run in SQLite and PostgreSQL 18. `scripts/verify.sh` re-checks the SQLite results on every push.

This calendar matches the channel's 90-day sprint (November 2, 2026 to January 31, 2027). SQL Lessons 3–7 fall in the next sprint, so their dates are proposals until the January review confirms them.

---

## Publish calendar

| Week of | Publishes (Tue) | Video | Repo lesson |
|---|---|---|---|
| Nov 9 | Nov 10, 2026 | Primary vs Foreign Keys: Explained Like a College Course | [Database Design 1](../lessons/database-design/01-primary-foreign-keys/) |
| Nov 16 | Nov 17 | Many-to-Many Relationships: The Junction Table Trick | [Database Design 2](../lessons/database-design/02-many-to-many/) |
| Nov 23 | Nov 24 | Database Normalization Explained: 1NF to 3NF With One Messy Table (Thanksgiving week: Short only if time is short) | [Database Design 3](../lessons/database-design/03-normalization/) |
| Nov 30 | Dec 1 | Can You Solve This ER Diagram Exam Question? | [Database Design 4](../lessons/database-design/04-er-diagram-exam-question/) |
| Dec 7 | Dec 8 | 7 Database Design Mistakes I See in Student Projects | [Database Design 5](../lessons/database-design/05-design-mistakes/) |
| Dec 14 | Dec 15 | Compilation: Database Design for Beginners, Lessons 1–5 | Reuses Database Design 1–5 |
| Dec 21 | none | Holiday buffer: 1 Short from the backlog | none |
| Dec 28 | Dec 29 | The SQL JOIN Mistake That Costs Students Points | [SQL 1](../lessons/sql/01-left-join-mistake/) |
| Jan 4 | Jan 5, 2027 | GROUP BY vs HAVING: 3 Exam Problems Solved | [SQL 2](../lessons/sql/02-group-by-having/) |
| Jan 11 | Jan 12 | How to Pass Your Database Course: Study Roadmap | No SQL (study guide video) |
| Jan 18 | Jan 19 | Superkey vs Candidate Key vs Primary Key | Not in the repo yet |
| Jan 25 | Jan 26 | SQL Practice Test: 10 Questions Explained (optional if time is short) | [SQL Practice Test](../lessons/sql/practice-test/) |
| Feb 1 | Feb 2 (proposed) | SQL WHERE and ORDER BY: The AND/OR Mistake That Costs Exam Points | [SQL 3](../lessons/sql/03-where-order-by/) |
| Feb 8 | Feb 9 (proposed) | SQL NULL, LIKE, IN and BETWEEN: Why "= NULL" Returns Nothing | [SQL 4](../lessons/sql/04-null-like-in-between/) |
| Feb 15 | Feb 16 (proposed) | SQL COUNT, SUM, AVG Explained: COUNT(*) vs COUNT(column) | [SQL 5](../lessons/sql/05-aggregate-functions/) |
| Feb 22 | Feb 23 (proposed) | SQL INNER JOIN Explained Step by Step (With Exam Problems) | [SQL 6](../lessons/sql/06-inner-join/) |
| Mar 1 | Mar 2 (proposed) | SQL Subqueries Explained: IN, NOT IN and the NULL Trap (spring midterms) | [SQL 7](../lessons/sql/07-subqueries/) |

## Why this order

1. **Design first.** Keys, relationships and normalization come first, because joins only make sense once you know why the data is split across tables. Fall finals season is when students search for these topics.
2. **Then the most-failed SQL topics.** The LEFT JOIN mistake and GROUP BY vs HAVING come next, followed by a practice test for the start of the spring semester.
3. **Then the SQL foundations.** WHERE, NULL, aggregates, INNER JOIN and subqueries fill in the rest of a first SQL course.

**Course order for learners:** SQL 3, 4, 5, 2, 6, 1, 7, then the Practice Test.

## The trap in each lesson

Every lesson has a trap problem built on the deliberately messy data in `campus.sql`. Viewers see why the obvious answer is wrong, not only what the right one is.

| Lesson | Trap |
|---|---|
| Database Design 1 | SQLite accepts a section taught by instructor I9, who doesn't exist, until `PRAGMA foreign_keys = ON`. |
| Database Design 2 | The junction table's two-column key rejects a duplicate enrollment. |
| Database Design 3 | Dr. Shah's office is stored twice, so one move needs two updates (update anomaly). |
| Database Design 4 | A product column in the order table can't hold a second product. The price belongs on the order line. |
| Database Design 5 | Seven mistakes, each shown failing in SQL: a name as the key, a stale stored total, a ZIP code stored as a number, and more. |
| SQL 1 | A WHERE filter on the right-hand table turns a LEFT JOIN into an inner join, and two instructors vanish. |
| SQL 2 | Grouping by name merges the two students named Jordan Lee. |
| Practice Test | Question 5's missing parentheses return two extra students. |
| SQL 3 | AND runs before OR, so a "fall only" filter returns a spring section. SQLite and PostgreSQL also sort NULLs differently. |
| SQL 4 | `Grade <> 'A'` skips the 15 NULL grades, returning 4 instead of 19. |
| SQL 5 | SUM and AVG of all-NULL values return NULL, not 0. |
| SQL 6 | Section S5 has no instructor, so an INNER JOIN turns 8 sections into 7 rows. |
| SQL 7 | `NOT IN` against a list containing NULL returns 0 rows. `NOT EXISTS` returns the 3 instructors who mentor no one. |

## Reuse across lessons

- **Description boilerplate:** "Download the sample database (campus.sql) to follow along: https://github.com/JohnConklin/sql-like-a-college-course". Use the same link in every video.
- **Callbacks:** SQL 6 ends on the dropped section S5 and points to SQL 1, where a LEFT JOIN brings it back. SQL 7's trap reuses the NULL rule from SQL 4.
- **Next up:** SELECT basics and Superkey vs Candidate Key are the remaining topics without a repo lesson.

---

© 2026 John Conklin. Text licensed under [CC BY 4.0](https://creativecommons.org/licenses/by/4.0/). SQL code licensed under the [MIT License](../LICENSE).
