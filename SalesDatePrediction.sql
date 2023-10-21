
WITH OrderedOrders AS (
    SELECT
        CustID,
        OrderDate,
        LAG(OrderDate) OVER (PARTITION BY CustID ORDER BY OrderDate) AS PrevOrderDate
    FROM
        Sales.Orders as O
)

SELECT
    
	companyname CustomerName,
    MAX(orderdate) AS LastOrderDate,
	DATEADD(
        DAY,
		AVG(DATEDIFF(DAY, PrevOrderDate, OrderDate)) ,
        MAX(OrderDate)
    ) AS NextPredictedOrder

FROM
    OrderedOrders O
	inner join Sales.Customers as C on  O.custid=C.custid
WHERE
    PrevOrderDate IS NOT NULL
GROUP BY
    companyname;