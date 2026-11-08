-- SPDX-License-Identifier: MIT
-- Copyright (c) 2026 John Conklin
-- Database Design · Lesson 4: Can You Solve This ER Diagram Exam Question?
-- Database: empty
-- Run this file in a NEW, EMPTY database (not campus.db):
--   sqlite3 lesson.db < solution.sql
-- Every query below was tested in SQLite and PostgreSQL 18.
-- Statements that are SUPPOSED to fail are commented out. Uncomment one to watch it fail.

PRAGMA foreign_keys = ON;   -- SQLite only; PostgreSQL always enforces foreign keys
.headers on
.mode column

-- ===== L4-setup (run in a new, empty database) =====
-- Setup: Lesson 4
CREATE TABLE Customer (
    CustomerID  CHAR(3)      PRIMARY KEY,
    Name        VARCHAR(40)  NOT NULL,
    Email       VARCHAR(60)  NOT NULL UNIQUE
);

CREATE TABLE CustomerOrder (
    OrderID     CHAR(4)  PRIMARY KEY,
    OrderDate   DATE     NOT NULL,
    CustomerID  CHAR(3)  NOT NULL REFERENCES Customer(CustomerID)
);

CREATE TABLE Product (
    ProductID    CHAR(3)       PRIMARY KEY,
    ProductName  VARCHAR(40)   NOT NULL,
    ListPrice    DECIMAL(8,2)  NOT NULL
);

CREATE TABLE OrderLine (
    OrderID    CHAR(4)       NOT NULL REFERENCES CustomerOrder(OrderID),
    ProductID  CHAR(3)       NOT NULL REFERENCES Product(ProductID),
    Quantity   INTEGER       NOT NULL CHECK (Quantity > 0),
    UnitPrice  DECIMAL(8,2)  NOT NULL,
    PRIMARY KEY (OrderID, ProductID)
);

INSERT INTO Customer VALUES
    ('C01', 'Ana Garcia', 'agarcia@example.com'),
    ('C02', 'Ben Ortiz',  'bortiz@example.com');
INSERT INTO Product VALUES
    ('P01', 'Desk Lamp', 24.50),
    ('P02', 'Notebook',   3.25),
    ('P03', 'USB Cable',  8.99);
INSERT INTO CustomerOrder VALUES
    ('O100', '2026-10-02', 'C01'),
    ('O101', '2026-10-15', 'C02');
INSERT INTO OrderLine VALUES
    ('O100', 'P01', 1, 24.50),
    ('O100', 'P02', 3,  3.25),
    ('O101', 'P03', 2,  8.99);

-- ===== L4-1 (raise the lamp's price, then compare totals) =====
-- Expected:
-- | OrderID | ChargedTotal | AtTodaysPrice |
-- | O100 | 34.25 | 37.74 |
-- | O101 | 17.98 | 17.98 |
UPDATE Product SET ListPrice = 27.99 WHERE ProductID = 'P01';

SELECT o.OrderID,
       ROUND(SUM(ol.Quantity * ol.UnitPrice), 2) AS ChargedTotal,
       ROUND(SUM(ol.Quantity * p.ListPrice), 2) AS AtTodaysPrice
FROM CustomerOrder AS o
JOIN OrderLine AS ol ON ol.OrderID = o.OrderID
JOIN Product AS p ON p.ProductID = ol.ProductID
GROUP BY o.OrderID
ORDER BY o.OrderID;

-- ===== L4-2 (the wrong design: a product column in the order table) =====
-- Expected: error. The second insert fails with a duplicate key error in both databases, so order O100 can't hold a second product.
BEGIN;
CREATE TABLE BadOrder (
    OrderID     CHAR(4)  PRIMARY KEY,
    OrderDate   DATE     NOT NULL,
    CustomerID  CHAR(3)  NOT NULL,
    ProductID   CHAR(3)  NOT NULL,
    Quantity    INTEGER  NOT NULL
);
INSERT INTO BadOrder VALUES ('O100', '2026-10-02', 'C01', 'P01', 1);
-- The next statement is the one that fails:
-- INSERT INTO BadOrder VALUES ('O100', '2026-10-02', 'C01', 'P02', 3);
ROLLBACK;   -- undo, so later queries see the original data
