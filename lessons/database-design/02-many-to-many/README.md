# Database Design · Lesson 2: Many-to-Many Relationships: The Junction Table Trick

Spot M:N, build the junction table, query it both ways.

- **Video:** publishes Tue, Nov 17, 2026. Link coming soon.
- **Database:** [`database/campus.sql`](../../../database/campus.sql) (Problem 2 uses its own small tables; see below)

## Prove it

Pause the video and try each problem before you look at the solution.

1. **Easy** Classify each pair from campus.sql as 1:1, 1:N or M:N. a. Course – Section b. Student – Section c. Department – Course

2. **Medium** A student can join zero or many clubs. A club can have zero or many members. Each membership records JoinDate and Role (Member, Treasurer, President). Ana is President of Chess Club and a Member of Coding Club. Design the tables. Where do JoinDate and Role go?

3. **Hard** campus.sql already has a junction table. Find it. Then write two queries: a. Every section Maya Patel (10024) is in, with course titles. b. Every student in section S4.


## Check your work

- [`solution.sql`](solution.sql)
- [`solution-part2.sql`](solution-part2.sql)

The expected output for every query is in the comments above it. Statements that are supposed to fail are commented out, so the file runs cleanly. Uncomment one to watch the database reject it.

SQLite users: the solution files turn on `PRAGMA foreign_keys = ON;`, because SQLite ignores foreign keys without it.

---

© 2026 John Conklin. Text licensed under [CC BY 4.0](https://creativecommons.org/licenses/by/4.0/). SQL code licensed under the [MIT License](../../../LICENSE).
