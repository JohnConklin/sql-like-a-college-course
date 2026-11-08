# Database Design · Lesson 4: Can You Solve This ER Diagram Exam Question?

Online store · 10-point rubric.

- **Video:** publishes Tue, Dec 1, 2026. Link coming soon.
- **Database:** each solution file builds its own small tables. Run it in a new, empty database.

## Prove it

Pause the video and try each problem before you look at the solution.

Draw the ER diagram for this scenario. Name every entity, its primary key, each relationship, and both minimums and maximums. Then turn it into tables.

> An online store sells products to customers. A customer can place zero or many orders, but each order is placed by exactly one customer. An order must contain at least one product, and it can contain many. A product can appear on many orders or on none. For every product on an order, the store records the quantity and the price charged at the time of purchase, because prices change over time. The store tracks each customer's name and email, each order's date, and each product's name and current list price.


## Check your work

- [`solution.sql`](solution.sql)

The expected output for every query is in the comments above it. Statements that are supposed to fail are commented out, so the file runs cleanly. Uncomment one to watch the database reject it.

SQLite users: the solution files turn on `PRAGMA foreign_keys = ON;`, because SQLite ignores foreign keys without it.

---

© 2026 John Conklin. Text licensed under [CC BY 4.0](https://creativecommons.org/licenses/by/4.0/). SQL code licensed under the [MIT License](../../../LICENSE).
