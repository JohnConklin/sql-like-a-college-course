# SQL Like a College Course

**Learn it, then prove it.** Free SQL and database design lessons taught the way a college course teaches them, by a real instructor. Each lesson explains the concept and why it works, then solves exam-style problems, including a trap question built on the mistakes students actually make.

Every lesson uses the same sample college database, `campus.sql`, so you set it up once and follow along with the whole series. It's the same database used in the videos and in the free practice-pack samples, so every result here matches what you see on screen.

## Lessons

The table is in publish order. Video links are added as each lesson goes live.

### Database Design

| # | Lesson | Publishes |
|---|---|---|
| 1 | [Primary vs Foreign Keys](lessons/database-design/01-primary-foreign-keys/) | Tue, Nov 10, 2026 |
| 2 | [Many-to-Many Relationships: The Junction Table Trick](lessons/database-design/02-many-to-many/) | Tue, Nov 17, 2026 |
| 3 | [Normalization: 1NF to 3NF With One Messy Table](lessons/database-design/03-normalization/) | Tue, Nov 24, 2026 |
| 4 | [Can You Solve This ER Diagram Exam Question?](lessons/database-design/04-er-diagram-exam-question/) | Tue, Dec 1, 2026 |
| 5 | [7 Database Design Mistakes I See in Student Projects](lessons/database-design/05-design-mistakes/) | Tue, Dec 8, 2026 |

### SQL

| # | Lesson | Publishes |
|---|---|---|
| 1 | [The SQL JOIN Mistake That Costs Students Points](lessons/sql/01-left-join-mistake/) (LEFT JOIN) | Tue, Dec 29, 2026 |
| 2 | [GROUP BY vs HAVING: 3 Exam Problems Solved](lessons/sql/02-group-by-having/) | Tue, Jan 5, 2027 |
| Test | [SQL Practice Test: 10 Questions Explained](lessons/sql/practice-test/) | Tue, Jan 26, 2027 |
| 3 | [WHERE and ORDER BY: The AND/OR Mistake](lessons/sql/03-where-order-by/) | Tue, Feb 2, 2027 (proposed) |
| 4 | [NULL, LIKE, IN and BETWEEN: Why "= NULL" Returns Nothing](lessons/sql/04-null-like-in-between/) | Tue, Feb 9, 2027 (proposed) |
| 5 | [COUNT, SUM, AVG: COUNT(*) vs COUNT(column)](lessons/sql/05-aggregate-functions/) | Tue, Feb 16, 2027 (proposed) |
| 6 | [INNER JOIN Explained Step by Step](lessons/sql/06-inner-join/) | Tue, Feb 23, 2027 (proposed) |
| 7 | [Subqueries: IN, NOT IN and the NULL Trap](lessons/sql/07-subqueries/) | Tue, Mar 2, 2027 (proposed) |

**New to SQL? Study them in this order:** SQL 3, 4, 5, 2, 6, 1, 7, then the Practice Test. The lessons were published in a different order, but each one builds on the lessons before it in this list. The [roadmap](docs/roadmap.md) has the full calendar.

## Quick start

1. Install [DB Browser for SQLite](https://sqlitebrowser.org/) (free), or use the `sqlite3` command-line tool.
2. Build the database:
   - **DB Browser:** New Database → save as `campus.db` → Execute SQL tab → open `database/campus.sql` → Run.
   - **Command line:**
     ```bash
     sqlite3 campus.db < database/campus.sql
     ```
   - **PostgreSQL:** `createdb campus && psql -d campus -f database/campus.sql`
3. Open a lesson folder, try the problems in its `README.md`, then check your work against its solution file. The expected output for every query is in the comments.

**SQLite tip:** run `PRAGMA foreign_keys = ON;` first. SQLite ignores foreign keys without it. The solution files do this for you.

A few design lessons build their own small example tables. Their solution files say "Run this file in a new, empty database" at the top.

## The sample database

| Table | What it holds | Key |
|---|---|---|
| `Department` | 4 academic departments | `DeptID` |
| `Instructor` | 5 instructors, with an optional mentor | `InstructorID` → `Department`; `MentorID` → `Instructor` |
| `Course` | 6 courses | `CourseID` → `Department` |
| `Section` | 8 sections across Spring 2026 and Fall 2026 | `SectionID` → `Course`, `Instructor` |
| `Student` | 10 students | `StudentID` |
| `Enrollment` | 23 enrollments, the junction table between students and sections | (`StudentID`, `SectionID`) |

The data includes realistic "messy" cases on purpose. A section with no instructor yet (S5). Two different students named Jordan Lee. A student with no enrollments. Instructors with no fall sections. A course that has never been offered. Fall grades that are still NULL. These make the trap problems work.

## Repository layout

```
database/campus.sql          Builds the sample database (run this first)
lessons/database-design/     Database design lessons: problems (README.md) and solutions (*.sql)
lessons/sql/                 SQL lessons: problems (README.md) and solutions (*.sql)
docs/roadmap.md              Publish calendar and series plan
docs/video-scripts/          Slide-by-slide video scripts
scripts/verify.sh            Runs every solution and checks every expected result
scripts/check_expected.py    The result checker used by verify.sh
```

## Verify everything runs

```bash
./scripts/verify.sh
```

It runs every solution file in a fresh database. Then it compares each query's result with the expected output written in the file, and confirms that every statement marked "error" really fails. GitHub Actions runs the same check on every push. The queries were also tested in PostgreSQL 18. The only place the two databases differ is where SQLite and PostgreSQL sort NULLs, and SQL Lesson 3 teaches that difference on purpose.

## Feedback

Found a bug or have a question about a problem? Open an issue, or leave a comment on the video.

## License

This repository uses two licenses:

| What | License | File |
|---|---|---|
| **Code:** all `.sql` files, `scripts/`, `.github/` | [MIT](LICENSE) | `LICENSE` |
| **Lesson text and docs:** all `README.md` files, `docs/` | [CC BY 4.0](https://creativecommons.org/licenses/by/4.0/) | `LICENSE-CC-BY-4.0.txt` |

You're free to use the SQL in your own projects or classes, and to share or adapt the lesson text, with credit.

**Attribution for the lesson text:** "SQL Like a College Course" by John Conklin, licensed under CC BY 4.0, https://github.com/JohnConklin/sql-like-a-college-course
