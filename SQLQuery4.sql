CREATE TABLE dbo.Orders
(
  orderid   INT        NOT NULL
    CONSTRAINT PK_Orders PRIMARY KEY,
  orderdate DATE       NOT NULL,
  empid     INT        NOT NULL,
  custid    VARCHAR(5) NOT NULL,
  qty       INT        NOT NULL
);
INSERT INTO dbo.Orders(orderid, orderdate, empid, custid, qty)
VALUES
  (30001, '20200802', 3, 'A', 10),
  (10001, '20201224', 2, 'A', 12),
  (10005, '20201224', 1, 'B', 20),
  (40001, '20210109', 2, 'A', 40),
  (10006, '20210118', 1, 'C', 14),
  (20001, '20210212', 2, 'B', 12),
  (40005, '20220212', 3, 'A', 10),
  (20002, '20220216', 1, 'C', 20),
  (30003, '20220418', 2, 'B', 15),
  (30004, '20200418', 3, 'C', 22),
  (30007, '20220907', 3, 'D', 30);
SELECT 
    empid,
    COUNT(CASE WHEN YEAR(orderdate) = 2020 THEN orderid END) AS cnt2020,
    COUNT(CASE WHEN YEAR(orderdate) = 2021 THEN orderid END) AS cnt2020,
    COUNT(CASE WHEN YEAR(orderdate) = 2022 THEN orderid END) AS cnt2020
FROM dbo.Orders
GROUP BY empid;

SELECT 
    empid,
    SUM(CASE WHEN YEAR(orderdate) = 2020 THEN 1 ELSE 0 END) AS cnt2020,
    SUM(CASE WHEN YEAR(orderdate) = 2021 THEN 1 ELSE 0 END) AS cnt2020,
    SUM(CASE WHEN YEAR(orderdate) = 2022 THEN 1 ELSE 0 END) AS cnt2020
FROM dbo.Orders
GROUP BY empid;

SELECT orderid, custid, empid,
  DATAFROMPARTS(YEAR(orderdate), 12, 31) AS endofyear
FROM Sales_Orders
WHERE orderdate <> endofyear;, [])
}
/*
The problem is, SQL Sever processes the WHERE clause before the SELECT clause.
Meaning, the alias(temporary name assigned to the column) "endofyear" had not been created.
Approach should be...
*/
SELECT orderid, orderdate, custid, empid,
       DATEFROMPARTS(YEAR(orderdate), 12, 31) AS end_of_year_date
FROM Sales_Orders
WHERE orderdate <> DATEFROMPARTS(YEAR(orderdate), 12, 31);

--Use the actual expression instead of the alias. 

