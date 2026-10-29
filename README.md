# SQL Like a College Course

**Learn it, then prove it.** Free SQL and database design lessons taught the way a college course teaches them, by a real instructor. Each lesson explains the concept and *why* it works, then solves three exam-style problems, including a trap question built on the mistakes students actually make.

Every lesson uses the same sample college database, so you set it up once and follow along with the whole series.

## Lessons

| # | Lesson | Video |
|---|---|---|
| 1 | [Tables, Keys and SELECT](lessons/01-tables-keys-select/) | _coming soon_ |
| 2 | [WHERE and ORDER BY](lessons/02-where-order-by/) | _coming soon_ |
| 3 | [IN, BETWEEN, LIKE and NULL](lessons/03-in-between-like-null/) | _coming soon_ |
| 4 | [COUNT, SUM, AVG, MIN, MAX](lessons/04-aggregate-functions/) | _coming soon_ |
| 5 | [GROUP BY and HAVING](lessons/05-group-by-having/) | _coming soon_ |
| 6 | [Keys and Relationships (Design)](lessons/06-keys-and-relationships/) | _coming soon_ |
| 7 | [INNER JOIN](lessons/07-inner-join/) | _coming soon_ |
| 8 | [LEFT JOIN](lessons/08-left-join/) | _coming soon_ |
| 9 | [Subqueries](lessons/09-subqueries/) | _coming soon_ |
| 10 | [Normalization (1NF to 3NF)](lessons/10-normalization/) | _coming soon_ |

## Quick start

1. Install [DB Browser for SQLite](https://sqlitebrowser.org/) (free), or use the `sqlite3` command-line tool.
2. Build the database:
   - **DB Browser:** New Database → save as `campus.db` → Execute SQL tab → open `database/campus.sql` → Run.
   - **Command line:**
     ```bash
     sqlite3 campus.db < database/campus.sql
     ```
3. Open a lesson folder, try the problems in its `README.md`, then check your work against `solution.sql`.

## The sample database

| Table | What it holds | Key |
|---|---|---|
| `departments` | 4 academic departments | `dept_id` |
| `instructors` | 6 instructors | `instructor_id` → `departments` |
| `courses` | 10 courses | `course_id` → `departments`, `instructors` |
| `students` | 15 students | `student_id` |
| `enrollments` | 36 enrollments across 2 terms | (`student_id`, `course_id`, `term`) |
| `signup_sheet` | A deliberately messy table for the normalization lesson | none (on purpose) |

The data includes realistic "messy" cases on purpose: missing emails and GPAs, undeclared majors, a course with no instructor, a course with no students, a student with no enrollments, and course retakes. These are what make the trap problems work.

## Repository layout

```
database/campus.sql        Builds the sample database (run this first)
lessons/NN-topic/          Problems (README.md) and solutions (solution.sql) per lesson
solutions/answer_key.sql   All solutions in one file
scripts/verify.sh          Rebuilds the database and runs every solution
docs/roadmap.md            Series plan
```

## Verify everything runs

```bash
./scripts/verify.sh
```

GitHub Actions runs the same check on every push.

## Feedback

Found a bug or have a question about a problem? Open an issue, or leave a comment on the video.
