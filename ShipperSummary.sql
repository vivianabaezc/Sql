SELECT
    Shi.CompanyName,
    O.TotalFreight,
    SUM(OD.UnitPrice * OD.qty) AS TotalCostShipped,
    SUM(OD.qty) AS TotalItemsShipped
FROM
    Sales.Shippers AS Shi
INNER JOIN (
    SELECT
        ShipperID,
        SUM(Freight) AS TotalFreight
    FROM
        Sales.Orders
    GROUP BY
        ShipperID
) O ON Shi.ShipperID = O.ShipperID
INNER JOIN Sales.Orders AS O1 ON Shi.ShipperID = O1.ShipperID
INNER JOIN Sales.OrderDetails As OD ON O1.OrderID = OD.OrderID
GROUP BY
    Shi.CompanyName,
    O.TotalFreight
ORDER BY
    Shi.CompanyName ASC;