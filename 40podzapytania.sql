USE northwind
SELECT T.orderid, T.customerid
FROM ( SELECT orderid, customerid
FROM orders ) AS T
GO

SELECT productname, UnitPrice
,( SELECT AVG(UnitPrice) FROM products) AS average
,UnitPrice-(SELECT AVG(UnitPrice) FROM products) AS difference
FROM products

USE northwind
SELECT productname, unitprice
,( SELECT AVG(unitprice) FROM products) AS average
,unitprice-(SELECT AVG(unitprice) FROM products) AS
difference
FROM products
WHERE unitprice > ( SELECT AVG(unitprice) FROM products)

USE northwind
SELECT productname, unitprice
,( SELECT AVG(unitprice)
FROM products as p_wew
WHERE p_zew.categoryid = p_wew.categoryid ) AS
average
FROM products as p_zew

SELECT productname, unitprice, categoryid
 ,( SELECT AVG(unitprice)
 FROM products as p_wew
 WHERE p_zew.categoryid = p_wew.categoryid ) AS average ,
 unitprice - ( SELECT AVG(unitprice)
 FROM products as p_wew
 WHERE p_zew.categoryid = p_wew.categoryid ) AS dif
 FROM products as p_zew

USE northwind
SELECT DISTINCT productid, quantity
FROM [order details] AS ord1
WHERE quantity = ( SELECT MAX(quantity)
FROM [order details] AS ord2
WHERE ord1.productid =
ord2.productid )
ORDER BY productid

select productid, max(quantity)
from [order details]
group by productid
order by productid