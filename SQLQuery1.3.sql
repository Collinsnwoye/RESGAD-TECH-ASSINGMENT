SELECT custid, orderid, orderdate, freight
FROM (
    SELECT TOP 3
        custid, orderid, orderdate, freight
    FROM Sales.Orders
    ORDER BY custid, orderdate DESC
) AS RecentOrders;

