# Lesson 10: Normalization (1NF to 3NF)

Fix a messy table step by step, and see the anomalies that normalization prevents.

**Video:** _link coming soon_
**Database:** [`database/campus.sql`](../../database/campus.sql)

## Prove it

Pause the video and try each problem before looking at the solution.

1. Look at `signup_sheet`. Which column breaks First Normal Form (1NF), and how would you fix it?
2. Which columns depend on something other than the student? Redesign the table into 2NF/3NF.
3. **Trap:** Write a query that shows the update anomaly hiding in `signup_sheet`.

## Solution

Try the problems before opening [`solution.sql`](solution.sql).

---

© 2026 John Conklin. Text licensed under [CC BY 4.0](https://creativecommons.org/licenses/by/4.0/). SQL code licensed under the [MIT License](../../LICENSE).
