# Canva Video Scripts: SQL Lessons 3–7

Dr. John Conklin · For the SQL playlist on your channel

These are the next five SQL lessons after Lessons 1 and 2 (the JOIN mistake and GROUP BY vs HAVING) and the Practice Test. They fill in the core of a first SQL course:

| Badge | Code | Title | Proposed publish date |
|---|---|---|---|
| SQL · Lesson 3 | D | SQL WHERE and ORDER BY: The AND/OR Mistake That Costs Exam Points | Tue, Feb 2, 2027 |
| SQL · Lesson 4 | E | SQL NULL, LIKE, IN and BETWEEN: Why "= NULL" Returns Nothing | Tue, Feb 9 |
| SQL · Lesson 5 | F | SQL COUNT, SUM, AVG Explained: COUNT(*) vs COUNT(column) | Tue, Feb 16 |
| SQL · Lesson 6 | G | SQL INNER JOIN Explained Step by Step (With Exam Problems) | Tue, Feb 23 |
| SQL · Lesson 7 | H | SQL Subqueries Explained: IN, NOT IN and the NULL Trap | Tue, Mar 2 (spring midterms) |

**Where these come from:**
- **Topics:** the SQL topics from the original roadmap in your GitHub repo that didn't have scripts yet. SELECT basics is the only one still unscripted.
- **Dataset:** the 10-student campus.sql from your practice packs, the same one used in the earlier lessons and the free samples. Since November 8, 2026, your GitHub repo uses this database too, so every result in the repo matches the videos.
- **Dates:** the 90-day sprint ends January 31, so these dates are proposals for the next sprint. Confirm them at the Week 13 review.
- **Playlist order:** in a course-order playlist, put these before the JOIN and GROUP BY lessons: Lesson 3, 4, 5, then 2 (GROUP BY), 6 (INNER JOIN), 1 (the JOIN mistake), 7 (subqueries), then the Practice Test. YouTube lets you reorder a playlist by hand.

**How the scripts were checked:**
- Every query and output below was run against campus.sql in SQLite and PostgreSQL 18.
- Both databases returned the same rows, except one block in Lesson 3, where the lesson is the difference.
- Build each lesson with the same Canva Steps 1–3 and the same **SQL Lesson Master** as SQL Lessons 1 and 2.

---

## Lesson D: SQL WHERE and ORDER BY: The AND/OR Mistake That Costs Exam Points

- **Badge:** SQL · Lesson 3
- **Search phrase:** "sql where clause and or". Check autocomplete.
- **Target length:** 11–13 minutes.
- **Tables used:** Student, Course and Section.
- **Thumbnail:** Stage 3 concept 2, red X / green check on two WHERE clauses. Text: "5 ROWS? SHOULD BE 4".
- **Practice-pack overlap:** none. The AND/OR question on the Practice Test (Question 5) uses students. This lesson uses sections.

| # | Layout | On-slide content | Narration (speaker notes) |
|---|---|---|---|
| 1 | Hook | Code D3-wrong. Red "-10". Text: "Fall only. So why is S6 here?" | "This query asks for fall sections taught by Dr. Kim or Dr. Ortiz. It returns five rows, and one of them is from spring. No error, no warning. By the end of this lesson, you'll see why in one glance and fix it with two characters." |
| 2 | Lesson title | Badge: "SQL · Lesson 3". Title: "SQL WHERE and ORDER BY: The AND/OR Mistake That Costs Exam Points". Subtitle: "Filter rows, sort results, and read AND/OR the way SQL does" | "This lesson is for anyone in a first database course. WHERE decides which rows you get. ORDER BY decides the order they're shown in. Three problems, and the last one is the mistake I mark wrong most often on this topic." |
| 3 | Concept | "WHERE keeps rows where the condition is true." / "ORDER BY only sorts. It never removes rows." / "AND runs before OR." | "Three rules. WHERE tests every row and keeps only the ones where the condition is true. ORDER BY sorts what's left, and it never filters anything. And when a condition mixes AND with OR, SQL does the ANDs first, the way math does multiplication before addition." |
| 4 | Dataset | Student: StudentID, Name, Major (10 rows). Section: SectionID, CourseID, Term, InstructorID (S1–S8; S5 is NULL) | "The same free campus database as the rest of the series. It's in the description. Look at the Term column in Section. Two sections are Spring 2026, S3 and S6. Remember S6." |
| 5 | Problem | "PROBLEM 1 · EASY". "List every Computer Science major's ID and name, sorted by name." | "Problem one. Every Computer Science major, ID and name, alphabetical by name. Pause and write it." |
| 6 | Output | Code D1, output D1 (4 rows) | "WHERE Major equals 'Computer Science', then ORDER BY Name. Four students. Two notes for exams: text values go in single quotes, and the match is exact. 'Comp Sci' would return nothing." |
| 7 | Problem | "PROBLEM 2 · MEDIUM". "List every course, highest credits first. Break ties alphabetically by title." | "Problem two. Every course, most credits first, and when two courses have the same credits, alphabetical by title. Pause." |
| 8 | Output | Code D2, output D2 (6 rows). Highlight: "DESC applies only to Credits" | "Two sort keys, separated by a comma. Credits DESC puts the four-credit courses first. Title breaks the ties, ascending, because DESC only applies to the column right before it. A common mistake is thinking one DESC flips everything." |
| 9 | Concept (open loop) | "Problem 3 runs, returns rows, and is still wrong." | "Problem three is the hook from the start. It runs. It returns rows. And it loses points, because of the order SQL reads AND and OR." |
| 10 | Problem | "PROBLEM 3 · HARD". "List the Fall 2026 sections taught by I2 (Dr. Kim) or I3 (Dr. Ortiz)." Code D3-wrong. "This returns 5 rows. Find the bug." | "Fall 2026 sections taught by Dr. Kim or Dr. Ortiz. Here's a classmate's query. Five rows. Find the bug and fix it. Pause." |
| 11 | Wrong vs right | Left (X): code D3-wrong, output D3-wrong (5 rows, with S6 circled). Right (check): code D3, output D3 (4 rows) | "SQL did the AND first. It read this as: fall sections taught by Dr. Kim, plus every section Dr. Ortiz teaches, in any term. That's how spring's S6 got in. Put parentheses around the OR, and you get four rows, all fall. My rule: whenever AND and OR are in the same WHERE, add parentheses, even when you think you don't need them." |
| 12 | Wrong vs right | "Bonus: where does NULL sort?" Left: code D4, outputs D4 for SQLite (S5 first) and PostgreSQL (S5 last). Right: code D4-fix, output D4-fix | "One bonus, because it surprises people. Sort sections by InstructorID, and S5's NULL goes first in SQLite and last in PostgreSQL. Same query, different order. If the position of NULLs matters, say so: NULLS LAST works in both databases." |
| 13 | Recap and next | 1. "WHERE filters rows; ORDER BY only sorts." 2. "DESC applies to one column." 3. "AND before OR: use parentheses." Next: "SQL Lesson 4: NULL, LIKE, IN and BETWEEN". "Free practice problems: link in the description" | "WHERE filters. ORDER BY sorts. DESC applies to one column. And AND runs before OR, so use parentheses. Next lesson: NULL, the value that breaks every comparison you know, plus IN, BETWEEN and LIKE, which would have made today's fix even shorter." |

### Lesson D code and outputs

**D1**
```sql
SELECT StudentID, Name
FROM Student
WHERE Major = 'Computer Science'
ORDER BY Name;
```

| StudentID | Name |
|---|---|
| 10029 | Grace Okafor |
| 10022 | Jordan Lee |
| 10024 | Maya Patel |
| 10026 | Sam Whitfield |

**D2**
```sql
SELECT CourseID, Title, Credits
FROM Course
ORDER BY Credits DESC, Title;
```

| CourseID | Title | Credits |
|---|---|---|
| CS310 | Data Structures | 4 |
| MA210 | Discrete Math | 4 |
| IS340 | Data Analytics | 3 |
| CS250 | Database Systems | 3 |
| CS101 | Intro to Programming | 3 |
| IS200 | Web Development | 3 |

**D3-wrong**
```sql
SELECT SectionID, Term, InstructorID
FROM Section
WHERE Term = 'Fall 2026'
  AND InstructorID = 'I2'
   OR InstructorID = 'I3'
ORDER BY SectionID;
```

| SectionID | Term | InstructorID |
|---|---|---|
| S2 | Fall 2026 | I2 |
| S4 | Fall 2026 | I2 |
| S6 | Spring 2026 | I3 |
| S7 | Fall 2026 | I3 |
| S8 | Fall 2026 | I3 |

**D3**
```sql
SELECT SectionID, Term, InstructorID
FROM Section
WHERE Term = 'Fall 2026'
  AND (InstructorID = 'I2' OR InstructorID = 'I3')
ORDER BY SectionID;
```

| SectionID | Term | InstructorID |
|---|---|---|
| S2 | Fall 2026 | I2 |
| S4 | Fall 2026 | I2 |
| S7 | Fall 2026 | I3 |
| S8 | Fall 2026 | I3 |

**D4** (the same query sorts NULL differently in each database)
```sql
-- Compare databases
SELECT SectionID, InstructorID
FROM Section
ORDER BY InstructorID, SectionID;
```

**SQLite:**

| SectionID | InstructorID |
|---|---|
| S5 | NULL |
| S1 | I1 |
| S3 | I1 |
| S2 | I2 |
| S4 | I2 |
| S6 | I3 |
| S7 | I3 |
| S8 | I3 |

**PostgreSQL:**

| SectionID | InstructorID |
|---|---|
| S1 | I1 |
| S3 | I1 |
| S2 | I2 |
| S4 | I2 |
| S6 | I3 |
| S7 | I3 |
| S8 | I3 |
| S5 | NULL |

**D4-fix** (same order in both)
```sql
SELECT SectionID, InstructorID
FROM Section
ORDER BY InstructorID NULLS LAST, SectionID;
```

| SectionID | InstructorID |
|---|---|
| S1 | I1 |
| S3 | I1 |
| S2 | I2 |
| S4 | I2 |
| S6 | I3 |
| S7 | I3 |
| S8 | I3 |
| S5 | NULL |

`NULLS LAST` needs SQLite 3.30 or later, so check your version with `SELECT sqlite_version();` before recording.

### Lesson D Short (9:16, about 30 seconds)

| Page | On screen | Voiceover |
|---|---|---|
| 1 | Code D3-wrong. "Fall only?" | "This query asks for fall sections only. Look at the results." |
| 2 | Output D3-wrong, with "Spring 2026" circled in red | "A spring section. SQL ran the AND before the OR." |
| 3 | Code D3, parentheses in amber | "Two parentheses fix it." |
| 4 | Output D3 plus "Full lesson ↓" | "AND before OR, every time. The full lesson is linked here." |

---

## Lesson E: SQL NULL, LIKE, IN and BETWEEN: Why "= NULL" Returns Nothing

- **Badge:** SQL · Lesson 4
- **Search phrase:** "sql is null vs = null". Check autocomplete.
- **Target length:** 11–13 minutes.
- **Tables used:** Student and Enrollment.
- **Thumbnail:** Stage 3 concept 2. Text: "= NULL IS WRONG".
- **Practice-pack overlap:** none. Paid Problem 10 uses COALESCE to display NULLs, and this lesson doesn't. The `<> 'A'` trap is new.

| # | Layout | On-slide content | Narration (speaker notes) |
|---|---|---|---|
| 1 | Hook | Code E5-wrong. Text: "23 enrollments. 4 A's. So 19 aren't A's, right?" Output: "4" | "Twenty-three enrollments. Four of them are A's. So how many aren't A's? Nineteen, obviously. SQL says four. Fifteen students just vanished, and it's the same reason 'equals NULL' never works. That's this lesson." |
| 2 | Lesson title | Badge: "SQL · Lesson 4". Title: "SQL NULL, LIKE, IN and BETWEEN: Why \"= NULL\" Returns Nothing". Subtitle: "Four filters every exam tests, and the one that lies" | "Lesson four. Three shortcuts that make WHERE clauses shorter, IN, BETWEEN and LIKE, then NULL, which makes them all behave strangely. Three problems, and the third is the one from the start." |
| 3 | Concept | "IN: matches any value in a list." / "BETWEEN: includes both ends." / "LIKE: % = any characters, _ = exactly one." | "IN is a short way to write a chain of ORs. BETWEEN includes both of its end values. That's the exam question every time. And LIKE matches patterns: percent means any number of characters, and underscore means exactly one." |
| 4 | Concept | "NULL = unknown. Not 0, not blank." / "Anything compared to NULL is unknown." / "WHERE keeps only TRUE, so unknown rows drop out." / "Test it with IS NULL / IS NOT NULL." | "NULL means unknown. Not zero and not an empty string. Is unknown equal to 'A'? Unknown. Is it not equal to 'A'? Also unknown. WHERE keeps only rows where the test is true, so unknown rows quietly disappear. The only safe test is IS NULL." |
| 5 | Dataset | Student (10 rows). Enrollment: StudentID, SectionID, Grade, GradePoints. Text: "Spring 2026: graded. Fall 2026: Grade is NULL (in progress)." | "Same campus database. In Enrollment, the spring rows have grades. The fall rows are in progress, so Grade is NULL. Fifteen of them. Keep that number in mind." |
| 6 | Problem | "PROBLEM 1 · EASY". "a. Students majoring in Mathematics or Data Analytics, using IN." / "b. Students with IDs from 10022 to 10025. How many rows?" | "Problem one, two quick parts. First, the Mathematics and Data Analytics majors, using IN. Second, students with IDs from 10022 through 10025. Predict the row count before you run it. Pause." |
| 7 | Output | Code E1, output E1 (3 rows). Code E2, output E2 (4 rows) | "Three students for part a, and IN replaced two ORs. Part b returns four rows, not two, because BETWEEN includes both 10022 and 10025. If you said two, you treated BETWEEN as 'strictly between,' and that's the most common BETWEEN mistake on exams." |
| 8 | Problem | "PROBLEM 2 · MEDIUM". "Find every student whose name has 'a' as the second letter." | "Problem two, a LIKE pattern. Every student whose name has a lowercase 'a' as its second letter. Pause." |
| 9 | Output | Code E3, output E3 (2 rows). Text: "_ = exactly 1 character" | "Underscore, then 'a', then percent. The underscore uses up exactly one character, the 'a' must come next, and the percent allows anything after. Maya and Sam. Ana Garcia isn't here, because her second letter is 'n'." |
| 10 | Concept (open loop) | "Problem 3: the 15 students that disappear." | "Problem three is the hook. Fifteen rows disappear, and no error tells you." |
| 11 | Problem | "PROBLEM 3 · HARD". "a. How many enrollments are still in progress?" / "b. How many enrollments are not an A?" Codes E4-wrong and E5-wrong, with "0" and "4" | "Two counts. In-progress enrollments, and enrollments that aren't an A. A classmate gets zero and four. Both are wrong. Fix both. Pause." |
| 12 | Wrong vs right | Left (X): E4-wrong = 0, E5-wrong = 4. Right (check): E4 = 15, E5 = 19 | "Part a: equals NULL is never true, so zero rows. IS NULL finds all fifteen. Part b is the sneaky one. Not-equal-to-A is unknown for every NULL grade, so those fifteen rows drop out, and you're left with only the four graded non-A rows. If in-progress counts as 'not an A,' add OR Grade IS NULL, and you get nineteen. Four plus nineteen is twenty-three. The numbers finally add up." |
| 13 | Recap and next | 1. "BETWEEN includes both ends." 2. "LIKE: % any characters, _ exactly one." 3. "NULL fails every comparison: use IS NULL." Next: "SQL Lesson 5: COUNT, SUM, AVG". "Free practice problems: link in the description" | "BETWEEN includes both ends. LIKE has two wildcards. And NULL fails every comparison, equals and not-equals alike, so test it with IS NULL. Next lesson: what COUNT, SUM and AVG do with those same NULLs. One of them returns NULL when you'd expect zero." |

### Lesson E code and outputs

**E1**
```sql
SELECT StudentID, Name, Major
FROM Student
WHERE Major IN ('Mathematics', 'Data Analytics')
ORDER BY StudentID;
```

| StudentID | Name | Major |
|---|---|---|
| 10023 | Jordan Lee | Data Analytics |
| 10027 | Priya Nair | Mathematics |
| 10030 | Ben Ortiz | Data Analytics |

**E2**
```sql
SELECT StudentID, Name
FROM Student
WHERE StudentID BETWEEN 10022 AND 10025
ORDER BY StudentID;
```

| StudentID | Name |
|---|---|
| 10022 | Jordan Lee |
| 10023 | Jordan Lee |
| 10024 | Maya Patel |
| 10025 | Tran Nguyen |

**E3**
```sql
SELECT StudentID, Name
FROM Student
WHERE Name LIKE '_a%'
ORDER BY Name;
```

| StudentID | Name |
|---|---|
| 10024 | Maya Patel |
| 10026 | Sam Whitfield |

**E4-wrong**
```sql
SELECT COUNT(*) AS InProgress
FROM Enrollment
WHERE Grade = NULL;
```

| InProgress |
|---|
| 0 |

**E4**
```sql
SELECT COUNT(*) AS InProgress
FROM Enrollment
WHERE Grade IS NULL;
```

| InProgress |
|---|
| 15 |

**E5-wrong**
```sql
SELECT COUNT(*) AS NotA
FROM Enrollment
WHERE Grade <> 'A';
```

| NotA |
|---|
| 4 |

**E5**
```sql
SELECT COUNT(*) AS NotA
FROM Enrollment
WHERE Grade <> 'A' OR Grade IS NULL;
```

| NotA |
|---|
| 19 |

**Slide 9 note:** LIKE is case-sensitive in PostgreSQL and case-insensitive in SQLite. E3 gives the same 2 rows in both databases because no name starts with a letter followed by a capital "A". Say "lowercase a" on the slide.

### Lesson E Short (9:16, about 30 seconds)

| Page | On screen | Voiceover |
|---|---|---|
| 1 | "23 enrollments · 4 A's · How many aren't A's?" | "Twenty-three enrollments, four A's. How many aren't A's?" |
| 2 | Code E5-wrong, output "4" in red | "SQL says four. Fifteen rows are missing." |
| 3 | "NULL <> 'A' → unknown → dropped" | "Those fifteen have NULL grades, and NULL fails every comparison." |
| 4 | Code E5, output 19, plus "Full lesson ↓" | "Add OR Grade IS NULL. Nineteen. The full NULL lesson is linked here." |

---

## Lesson F: SQL COUNT, SUM, AVG Explained: COUNT(*) vs COUNT(column)

- **Badge:** SQL · Lesson 5
- **Search phrase:** "count(*) vs count(column)". Check autocomplete.
- **Target length:** 10–12 minutes.
- **Tables used:** Enrollment and Course.
- **Thumbnail:** Stage 3 concept 2. Text: "23 OR 8?".
- **Practice-pack overlap:**
  - Paid Problem 14 compares AVG with SUM divided by COUNT(*) per student, and paid Problem 16 counts distinct students per department. This lesson works on the whole table and doesn't show either answer.
  - COALESCE appears once, in F3-fix. Paid Problem 10 uses it on different columns.

| # | Layout | On-slide content | Narration (speaker notes) |
|---|---|---|---|
| 1 | Hook | Code F1, with the three numbers hidden. Text: "Same table. Three different counts." | "One table, three counts, three different answers. All three are correct. If you can explain why before the end of this lesson, you're ready for the aggregate questions on any SQL exam." |
| 2 | Lesson title | Badge: "SQL · Lesson 5". Title: "SQL COUNT, SUM, AVG Explained: COUNT(*) vs COUNT(column)". Subtitle: "Five functions, one rule about NULL" | "Lesson five. COUNT, SUM, AVG, MIN and MAX turn many rows into one answer. They're simple, until NULLs show up. Last lesson was about NULL in WHERE. This one is NULL inside your totals." |
| 3 | Concept | "Aggregates collapse many rows into one value." / "COUNT(*) counts rows." / "Every other aggregate skips NULLs." | "An aggregate function takes a column of rows and returns one value. COUNT star counts rows, no matter what's in them. Every other aggregate, including COUNT of a column, skips NULLs first. That one rule explains almost every trick question." |
| 4 | Dataset | Enrollment: StudentID, SectionID, Grade, GradePoints. "23 rows · 8 graded (Spring) · 15 in progress (Fall, NULL)" | "Enrollment again. Twenty-three rows. The eight spring rows have grades. The fifteen fall rows are NULL, because the term isn't over. You saw that split last lesson." |
| 5 | Problem | "PROBLEM 1 · EASY". "In one query: total enrollment rows, rows with a grade, and different students enrolled." | "Problem one. In one query, count three things: all enrollment rows, rows that have a grade, and how many different students are enrolled. Pause." |
| 6 | Output | Code F1, output F1 (23, 8, 9) | "COUNT star: twenty-three rows. COUNT of Grade: eight, because it skips the fifteen NULLs. COUNT DISTINCT StudentID: nine, because many students have several enrollments. Ben Ortiz has none, which is why it's nine and not ten." |
| 7 | Problem | "PROBLEM 2 · MEDIUM". "For graded enrollments: lowest, highest and average grade points, rounded to 2 places." | "Problem two. For the graded enrollments, the lowest grade points, the highest, and the average, rounded to two decimal places. Pause." |
| 8 | Output | Code F2, output F2 (2, 4, 3.38) | "MIN is two, a C. MAX is four. The average is 3.375, which ROUND shows as 3.38. And look what happens if you drop the WHERE clause: AVG still returns 3.38, because AVG skips the NULLs anyway. That's convenient, until it isn't." |
| 9 | Concept (open loop) | "Problem 3: what does SUM return when there's nothing to add?" | "Problem three. Most students say zero. The database disagrees." |
| 10 | Problem | "PROBLEM 3 · HARD". "For the Fall 2026 sections (S1, S2, S4, S5, S7, S8), predict all four values." Code F3 | "The fall sections only. Predict all four results: the row count, the graded count, the sum of grade points, and the average. Write down four values. Pause." |
| 11 | Wrong vs right | Left (X): "Prediction: 15, 0, 0, 0". Right (check): output F3 (15, 0, NULL, NULL), with code F3-fix and output 0 | "Fifteen rows, zero graded, and then NULL, NULL. COUNT returns zero when there's nothing to count. SUM and AVG return NULL when every value is NULL, because there's nothing to add and nothing to average. If a report needs zero, ask for it: COALESCE of SUM, zero. This is why your dashboard shows a blank instead of a zero." |
| 12 | Concept | "COUNT(*): rows." / "COUNT(col): non-NULL values." / "COUNT(DISTINCT col): different non-NULL values." / "SUM/AVG of all-NULL: NULL." | "Here's the whole lesson on one slide. Screenshot it. Four lines, and they cover every COUNT question I've ever put on an exam." |
| 13 | Recap and next | 1. "COUNT(*) counts rows; everything else skips NULL." 2. "DISTINCT counts different values." 3. "No values → SUM and AVG return NULL." Next: "SQL Lesson 2: GROUP BY vs HAVING" (or the next lesson in the playlist). "Free practice problems: link in the description" | "COUNT star counts rows, and everything else skips NULL. DISTINCT counts different values. And with nothing to add, SUM and AVG give NULL, not zero. Now that you can total a whole table, the GROUP BY lesson shows you how to total each group." |

### Lesson F code and outputs

**F1**
```sql
SELECT COUNT(*) AS AllRows,
       COUNT(Grade) AS Graded,
       COUNT(DISTINCT StudentID) AS Students
FROM Enrollment;
```

| AllRows | Graded | Students |
|---|---|---|
| 23 | 8 | 9 |

**F2**
```sql
SELECT MIN(GradePoints) AS Lowest,
       MAX(GradePoints) AS Highest,
       ROUND(AVG(GradePoints), 2) AS Average
FROM Enrollment
WHERE Grade IS NOT NULL;
```

| Lowest | Highest | Average |
|---|---|---|
| 2.0 | 4.0 | 3.38 |

**F2-nowhere** (slide 8: the same average without the WHERE)
```sql
SELECT ROUND(AVG(GradePoints), 2) AS Average
FROM Enrollment;
```

| Average |
|---|
| 3.38 |

**F3**
```sql
SELECT COUNT(*) AS Enrollments,
       COUNT(GradePoints) AS Graded,
       SUM(GradePoints) AS TotalPoints,
       AVG(GradePoints) AS AvgPoints
FROM Enrollment
WHERE SectionID IN ('S1', 'S2', 'S4', 'S5', 'S7', 'S8');
```

| Enrollments | Graded | TotalPoints | AvgPoints |
|---|---|---|---|
| 15 | 0 | NULL | NULL |

**F3-fix**
```sql
SELECT COALESCE(SUM(GradePoints), 0) AS TotalPoints
FROM Enrollment
WHERE SectionID IN ('S1', 'S2', 'S4', 'S5', 'S7', 'S8');
```

| TotalPoints |
|---|
| 0 |

**Display notes:**
- GradePoints is DECIMAL(2,1). PostgreSQL shows F2's Lowest and Highest, and H1's GradePoints, as `2.0` and `4.0`. SQLite shows `2` and `4`. Use `2.0` and `4.0` on slides, and if a viewer asks, it's display formatting, not a different answer.
- On slides, type the word NULL into F3's empty cells.

### Lesson F Short (9:16, about 30 seconds)

| Page | On screen | Voiceover |
|---|---|---|
| 1 | "SUM of no grades = ?" | "Fifteen enrollments, none graded yet. What's the sum of their grade points?" |
| 2 | Output F3, with "NULL" circled | "Not zero. NULL." |
| 3 | "COUNT → 0 · SUM/AVG → NULL" | "COUNT gives zero. SUM and AVG give NULL when there's nothing to add." |
| 4 | Code F3-fix plus "Full lesson ↓" | "Need a zero? Use COALESCE. The full lesson is linked here." |

---

## Lesson G: SQL INNER JOIN Explained Step by Step (With Exam Problems)

- **Badge:** SQL · Lesson 6
- **Search phrase:** "sql inner join explained". Check autocomplete.
- **Target length:** 12–14 minutes.
- **Tables used:** Student, Enrollment, Section, Course and Instructor.
- **Thumbnail:** Stage 3 concept 4, a diagram spotlight on two tables with matching key cells. Text: "WHERE'S ROW 8?".
- **Practice-pack overlap:**
  - **Problem 1** is free-sample Problem 1, taught in full, including its cross-join part.
  - **Problems 2 and 3 are new.** Paid Problems 2–5 (three tables deep, the ambiguous column, the wrong join key, row counts) aren't used.
  - The Practice Test's Question 8 drops S5 from fall sections only. Problem 3 here uses all terms.

| # | Layout | On-slide content | Narration (speaker notes) |
|---|---|---|---|
| 1 | Hook | "8 sections in." / Code G3 / "7 rows out." Badge: "WHERE'S ROW 8?" | "Eight sections go into this join, and seven come out. No error. No warning. One section just isn't there. By the end of this lesson, you'll know exactly which one, and why a join is allowed to do that." |
| 2 | Lesson title | Badge: "SQL · Lesson 6". Title: "SQL INNER JOIN Explained Step by Step". Subtitle: "Match rows across tables, then prove the row count" | "Lesson six. So far we've used one table at a time. Real questions need several, because a good design stores each fact once, in its own table. A join puts them back together. Three problems, and the last one is the hook." |
| 3 | Concept | "A join pairs rows where the keys are equal." / "INNER JOIN keeps only pairs that match." / "One row per match, not one per student." Diagram: Student 10021 connected to three Enrollment rows | "A join takes a row from one table and pairs it with every row in the other table where the key matches. INNER JOIN keeps only rows that found a partner. If Ana is enrolled in three sections, she shows up three times, once per match." |
| 4 | Concept | Step by step: "1. FROM Student" / "2. JOIN Enrollment ON e.StudentID = s.StudentID" / "3. WHERE filters the joined rows" / "4. SELECT picks columns, ORDER BY sorts" | "Here's the order to build every join. Start with FROM. Add a JOIN and write its ON condition, which is the matching column. Then WHERE filters the joined rows. SELECT and ORDER BY come last. Build it that way on paper and you'll never lose the thread." |
| 5 | Problem | "PROBLEM 1 · EASY". "List every Information Systems major and the sections they're enrolled in. Show StudentID, Name and SectionID, sorted by StudentID, then SectionID. How many rows?" | "Problem one, from the free practice sample. Every Information Systems major and their sections. Write it, then predict the row count. Pause." |
| 6 | Output | Code G1, output G1 (7 rows) | "Join Student to Enrollment on StudentID, filter to the major, and sort. Seven rows for three students, because Ana is in three sections. One row per match." |
| 7 | Wrong vs right | Left (X): code G1-wrong, output: 69. Right (check): code G1, 7 rows. Text: "3 students × 23 enrollments = 69" | "Part c of the same problem. Leave out the join condition, and every IS student is paired with every enrollment row. Three times twenty-three is sixty-nine. It's called a cross join, and SQL runs it without complaint. If a result looks too big, multiply the table sizes and check." |
| 8 | Problem | "PROBLEM 2 · MEDIUM". "List Dr. Kim's sections with each course title and credits." Tables: Section, Course, Instructor | "Problem two, three tables. Dr. Kim's sections, with the course title and credits. Her name is in Instructor, the title is in Course, and Section connects them. Pause." |
| 9 | Output | Code G2, output G2 (2 rows) | "Section is the middle table. It holds both CourseID and InstructorID. Join Course on CourseID, join Instructor on InstructorID, then filter on the name. Two sections. Every extra table means one more JOIN and one more ON." |
| 10 | Concept (open loop) | "Problem 3: 8 sections in, 7 rows out." | "Problem three is the hook. Eight sections, seven rows. Find the missing one." |
| 11 | Problem | "PROBLEM 3 · HARD". "List every section with its instructor's name." Code G3. "Section has 8 rows. Why does this return 7?" | "Every section with its instructor's name. Section has eight rows, and this join returns seven. Which section is missing, and why? Pause." |
| 12 | Output | Output G3 (7 rows). Code G3-count, output 8. Text: "S5: InstructorID is NULL → no match → dropped" | "S5 is missing. Its InstructorID is NULL, and NULL doesn't equal any instructor, so S5 has no partner, and an inner join drops rows without a partner. The query isn't broken. It answered a different question: sections that have an instructor. If you need every section, that's a LEFT JOIN, and Lesson 1 covers the mistake everyone makes with it." |
| 13 | Recap and next | 1. "INNER JOIN keeps only matching rows." 2. "One row per match. Check the count." 3. "No ON condition = cross join." Next: "SQL Lesson 1: The SQL JOIN Mistake (LEFT JOIN)". "Free practice problems: link in the description" | "Inner join keeps only matches. You get one row per match, so check the count. And a join with no ON condition is a cross join. Next, watch the LEFT JOIN lesson. It brings S5 back, and shows the WHERE clause that quietly removes it again." |

### Lesson G code and outputs

**G1** (free-sample Problem 1)
```sql
SELECT s.StudentID, s.Name, e.SectionID
FROM Student AS s
JOIN Enrollment AS e
  ON e.StudentID = s.StudentID
WHERE s.Major = 'Information Systems'
ORDER BY s.StudentID, e.SectionID;
```

| StudentID | Name | SectionID |
|---|---|---|
| 10021 | Ana Garcia | S3 |
| 10021 | Ana Garcia | S6 |
| 10021 | Ana Garcia | S7 |
| 10025 | Tran Nguyen | S4 |
| 10025 | Tran Nguyen | S6 |
| 10028 | Leo Martinez | S6 |
| 10028 | Leo Martinez | S7 |

**G1-wrong** (no join condition)
```sql
SELECT COUNT(*) AS RowsReturned
FROM Student AS s, Enrollment AS e
WHERE s.Major = 'Information Systems';
```

| RowsReturned |
|---|
| 69 |

**G2**
```sql
SELECT s.SectionID, c.Title, c.Credits
FROM Section AS s
JOIN Course AS c
  ON c.CourseID = s.CourseID
JOIN Instructor AS i
  ON i.InstructorID = s.InstructorID
WHERE i.Name = 'Dr. Kim'
ORDER BY s.SectionID;
```

| SectionID | Title | Credits |
|---|---|---|
| S2 | Intro to Programming | 3 |
| S4 | Database Systems | 3 |

**G3**
```sql
SELECT s.SectionID, s.CourseID, i.Name
FROM Section AS s
JOIN Instructor AS i
  ON i.InstructorID = s.InstructorID
ORDER BY s.SectionID;
```

| SectionID | CourseID | Name |
|---|---|---|
| S1 | CS101 | Dr. Shah |
| S2 | CS101 | Dr. Kim |
| S3 | CS250 | Dr. Shah |
| S4 | CS250 | Dr. Kim |
| S6 | IS200 | Dr. Ortiz |
| S7 | IS340 | Dr. Ortiz |
| S8 | IS200 | Dr. Ortiz |

**G3-count**
```sql
SELECT COUNT(*) AS Sections
FROM Section;
```

| Sections |
|---|
| 8 |

### Lesson G Short (9:16, about 30 seconds)

| Page | On screen | Voiceover |
|---|---|---|
| 1 | "3 students. 23 enrollments. How many rows?" over code G1-wrong | "Three students, twenty-three enrollments, no join condition. How many rows?" |
| 2 | "69" in red | "Sixty-nine. Every student paired with every enrollment." |
| 3 | Code G1, with the ON line in amber | "Add the ON condition, and you get one row per real match." |
| 4 | "7 rows" plus "Full INNER JOIN lesson ↓" | "Seven. The full INNER JOIN lesson is linked here." |

---

## Lesson H: SQL Subqueries Explained: IN, NOT IN and the NULL Trap

- **Badge:** SQL · Lesson 7
- **Search phrase:** "sql subquery tutorial". Check autocomplete.
- **Target length:** 12–14 minutes.
- **Tables used:** Student, Enrollment, Section and Instructor.
- **Thumbnail:** Stage 3 concept 2. Text: "NOT IN = NOTHING?".
- **Practice-pack overlap:**
  - Paid Problem 11 sets the NOT IN trap on Section.InstructorID.
  - This lesson sets it on Instructor.MentorID, a different column with a different answer, so the paid solution isn't shown.
  - The mentor data matches free-sample Problem 22, which viewers can try next.

| # | Layout | On-slide content | Narration (speaker notes) |
|---|---|---|---|
| 1 | Hook | Code H3-wrong. Text: "3 instructors mentor no one. This finds 0." Red "-10" | "Three instructors mentor no one. This query should find them. It returns nothing. No error, just an empty result. One NULL in a list is enough to wipe out a NOT IN, and by the end of this lesson, you'll never fall for it." |
| 2 | Lesson title | Badge: "SQL · Lesson 7". Title: "SQL Subqueries Explained: IN, NOT IN and the NULL Trap". Subtitle: "A question inside a question" | "Lesson seven. A subquery is a query inside another query. It answers one question so the outer query can ask the next. Three problems: one value, a list, and the trap." |
| 3 | Concept | "Subquery = a query in parentheses." / "One value: compare with =, >, <." / "A list: match with IN." / "Run the inner query first, by hand." | "The inner query runs first, at least in your head. If it returns one value, compare against it with equals or greater-than. If it returns a list, use IN. My advice for exams: run the inner query by itself first and look at what it returns. That habit catches the trap in problem three." |
| 4 | Dataset | Enrollment (GradePoints). Section (InstructorID). Instructor: InstructorID, Name, MentorID (I1 Shah NULL, I2 Kim I1, I3 Ortiz I1, I4 Brooks NULL, I5 Chen I3) | "Same campus database. New column: MentorID. Kim and Ortiz are mentored by Dr. Shah. Chen is mentored by Ortiz. Shah and Brooks have no mentor, so their MentorID is NULL." |
| 5 | Problem | "PROBLEM 1 · EASY". "Find every enrollment with grade points above the average." | "Problem one. Every enrollment with grade points above the overall average. You don't know the average yet. Let a subquery find it. Pause." |
| 6 | Output | Code H1, output H1 (4 rows). Text: "Inner query returns 3.375" | "The inner query returns one value, 3.375. AVG skips NULLs, from Lesson 5. The outer query keeps grade points above that. Four enrollments, all A's. You can't write AVG directly in WHERE, which is why the subquery exists." |
| 7 | Problem | "PROBLEM 2 · MEDIUM". "List every student enrolled in any section taught by Dr. Ortiz (I3). Each student once." | "Problem two. Every student in any of Dr. Ortiz's sections, each student listed once. Pause." |
| 8 | Wrong vs right | Left: join version, code H2-join, output: 9 rows (with repeats). Right (check): code H2, output H2 (6 students) | "The inner query returns a list of student IDs from Ortiz's sections, and IN keeps each student whose ID is on that list. Six students, each once. Write it as a plain join, and you get nine rows, because Ana, Jordan Lee and Leo are each in two of his sections. Both work, but IN answers 'who' without repeats." |
| 9 | Concept (open loop) | "Problem 3: IN's opposite, and the NULL that breaks it." | "If IN finds who's on the list, NOT IN should find who isn't. Usually. Problem three is the exception." |
| 10 | Problem | "PROBLEM 3 · HARD". "Find the instructors who mentor no one." Code H3-wrong. "Predict the result." | "Instructors who mentor nobody. Here's a classmate's NOT IN. Predict the result before you run it. Pause." |
| 11 | Wrong vs right | Left (X): code H3-wrong, output: 0 rows. Inner list shown: "I1, I1, I3, NULL, NULL". Right (check): code H3, output H3 (Kim, Brooks, Chen) | "Zero rows. Run the inner query alone: I1, I1, I3, and two NULLs. NOT IN asks: is Kim's ID different from every value on the list? Different from I1, yes. Different from NULL? Unknown. One unknown makes the whole test unknown, and WHERE drops the row. The fix is NOT EXISTS, which never compares against NULL. Three instructors: Kim, Brooks and Chen." |
| 12 | Output | Code H3-alt, output (same 3). Text: "Or remove the NULLs from the list." | "If you want to keep NOT IN, filter the NULLs out of the inner query with IS NOT NULL. Same three instructors. On my exams, either fix earns full credit. Running NOT IN against a column with NULLs costs points every time." |
| 13 | Recap and next | 1. "One value: compare. A list: IN." 2. "Run the inner query alone first." 3. "NOT IN + NULL = nothing. Use NOT EXISTS." Next: "SQL Practice Test: 10 Questions". "Free practice problems: link in the description" | "One value, compare. A list, IN. Always run the inner query by itself first. And NOT IN with a NULL on the list returns nothing, so use NOT EXISTS. That completes the core series. Test yourself with the ten-question practice test, and the free sample has a mentor problem to try next." |

### Lesson H code and outputs

**H1**
```sql
SELECT StudentID, SectionID, GradePoints
FROM Enrollment
WHERE GradePoints > (SELECT AVG(GradePoints) FROM Enrollment)
ORDER BY StudentID, SectionID;
```

| StudentID | SectionID | GradePoints |
|---|---|---|
| 10021 | S3 | 4.0 |
| 10023 | S6 | 4.0 |
| 10024 | S3 | 4.0 |
| 10025 | S6 | 4.0 |

**H2**
```sql
SELECT StudentID, Name
FROM Student
WHERE StudentID IN (
    SELECT e.StudentID
    FROM Enrollment AS e
    JOIN Section AS s
      ON s.SectionID = e.SectionID
    WHERE s.InstructorID = 'I3'
)
ORDER BY StudentID;
```

| StudentID | Name |
|---|---|
| 10021 | Ana Garcia |
| 10023 | Jordan Lee |
| 10025 | Tran Nguyen |
| 10027 | Priya Nair |
| 10028 | Leo Martinez |
| 10029 | Grace Okafor |

**H2-join** (the join version: 9 rows, with repeats)
```sql
SELECT COUNT(*) AS RowsReturned
FROM Student AS st
JOIN Enrollment AS e
  ON e.StudentID = st.StudentID
JOIN Section AS s
  ON s.SectionID = e.SectionID
WHERE s.InstructorID = 'I3';
```

| RowsReturned |
|---|
| 9 |

Nine rows for six students: Ana Garcia, Jordan Lee (10023) and Leo Martinez each appear twice, because each is in two of Dr. Ortiz's sections.

**H3-inner** (run the inner query alone)
```sql
SELECT MentorID
FROM Instructor
ORDER BY InstructorID;
```

| MentorID |
|---|
| NULL |
| I1 |
| I1 |
| NULL |
| I3 |

**H3-wrong**
```sql
SELECT Name
FROM Instructor
WHERE InstructorID NOT IN (SELECT MentorID FROM Instructor);
```
**Result:** 0 rows.

**H3**
```sql
SELECT i.Name
FROM Instructor AS i
WHERE NOT EXISTS (
    SELECT 1
    FROM Instructor AS m
    WHERE m.MentorID = i.InstructorID
)
ORDER BY i.InstructorID;
```

| Name |
|---|
| Dr. Kim |
| Dr. Brooks |
| Dr. Chen |

**H3-alt**
```sql
SELECT Name
FROM Instructor
WHERE InstructorID NOT IN (
    SELECT MentorID
    FROM Instructor
    WHERE MentorID IS NOT NULL
)
ORDER BY InstructorID;
```

| Name |
|---|
| Dr. Kim |
| Dr. Brooks |
| Dr. Chen |

**Slide 11 note:** the inner list on the slide is H3-inner's output, in InstructorID order: NULL, I1, I1, NULL, I3. Show it in that order, so it matches what viewers see when they run it.

### Lesson H Short (9:16, about 30 seconds)

| Page | On screen | Voiceover |
|---|---|---|
| 1 | Code H3-wrong. "Should return 3 instructors." | "This should return three instructors." |
| 2 | "0 rows" in red | "It returns zero." |
| 3 | Inner list "NULL, I1, I1, NULL, I3", with the NULLs circled | "The list has a NULL. NOT IN plus NULL always gives nothing." |
| 4 | Code H3 plus "Full subquery lesson ↓" | "Use NOT EXISTS. The full subquery lesson is linked here." |

---

## The campus database and the GitHub repo

These scripts use the 10-student campus.sql. Your GitHub repo, [SQL Like a College Course](https://github.com/JohnConklin/sql-like-a-college-course), ships the same file as `database/campus.sql`.

Each lesson here has a folder in the repo's `lessons/sql/` directory. It holds the problems, every query from the script, and the expected output for each query. GitHub re-runs and checks them on every push. Link the repo in each description as the place to download campus.sql.

If you change a query in a script, change it in the repo lesson too.

## Pre-publish checks

- [ ] Every code block on every slide matches this file exactly. Watch for curly quotes from Canva autocorrect.
- [ ] Every output table matches this file. NULL cells show the word "NULL", and Lesson 3's slide 12 shows the two database orders correctly labeled.
- [ ] Code is 28pt or larger and readable on a phone.
- [ ] No Pro (crown) elements were used.
- [ ] The description links the GitHub repo, which has the campus.sql used in the video.
- [ ] The Stage 5 publish checklist is complete.
