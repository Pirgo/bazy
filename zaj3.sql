
SELECT TOP 5 WITH TIES OrderID, productid, quantity
FROM [order details]
ORDER BY quantity DESC

SELECT COUNT (*)
FROM employees

SELECT COUNT(reportsto)
FROM employees

select ReportsTo from Employees

SELECT AVG(unitprice)
FROM products

SELECT SUM(quantity)
FROM [order details]

/* Podaj liczbę produktów o cenach mniejszych niż 10$ lub
większych niż 20$ */
select count(UnitPrice)
from Products where UnitPrice < 10 or UnitPrice > 20

/*Podaj maksymalną cenę produktu dla produktów o cenach
poniżej 20$ */
select max(UnitPrice)
from Products where UnitPrice < 20

select top 1 UnitPrice
from Products
where UnitPrice < 20
order by UnitPrice desc

/*Podaj maksymalną i minimalną i średnią cenę produktu dla
produktów o produktach sprzedawanych w butelkach
(‘bottle’)*/
select min(UnitPrice) as 'min', max(UnitPrice) as 'max', avg(UnitPrice) as 'avg'
from Products
where QuantityPerUnit LIKE '%bottle%'

/*Wypisz informację o wszystkich produktach o cenie powyżej
średniej*/
select  avg(UnitPrice) from Products
select * from Products where UnitPrice > 28.8663

--Podaj sumę/wartość zamówienia o numerze 10250
select sum(UnitPrice * Quantity * (1 - Discount)) from [Order Details] where OrderID = 10250

SELECT productid
,SUM(quantity) AS total_quantity
FROM orderhist
GROUP BY productid

SELECT productid, SUM(quantity) AS total_quantity
FROM [order details]
GROUP BY productid

/*Podaj maksymalną cenę zamawianego produktu dla każdego
zamówienia*/
select OrderID, MAX(UnitPrice) as max_unitprice from [Order Details]
GROUP BY OrderID

/*Posortuj zamówienia wg maksymalnej ceny produktu*/
select OrderID, MAX(UnitPrice) as max_unitprice from [Order Details]
GROUP BY OrderID order by max_unitprice

/*Podaj maksymalną i minimalną cenę zamawianego produktu dla
każdego zamówienia*/
select OrderID, MAX(UnitPrice) as max_unitpricen, MIN(UnitPrice) from [Order Details]
GROUP BY OrderID

/*Podaj liczbę zamówień dostarczanych przez poszczególnych
spedytorów (przewoźników)*/
select count(orderid), ShipVia from Orders group by ShipVia

/*Który z spedytorów był najaktywniejszy w 1997 roku*/
select ShipVia, count(ShippedDate) as res from Orders where year(ShippedDate) = 1997 group by ShipVia order by res


SELECT productid, SUM(quantity) AS total_quantity
FROM [order details]
GROUP BY productid
HAVING SUM(quantity)>1200

/*Wyświetl zamówienia dla których liczba pozycji zamówienia jest
większa niż 5*/
select OrderID, count(OrderID) from [Order Details] group by OrderID having count(OrderID) > 5

/*Wyświetl klientów dla których w 1998 roku zrealizowano więcej
niż 8 zamówień (wyniki posortuj malejąco wg łącznej kwoty za
dostarczenie zamówień dla każdego z klientów)*/
select CustomerID, count(*) from Orders where year(OrderDate) = 1998
group by CustomerID having count(*) > 8 order by sum(Freight) desc

-- select CustomerID, count(*) from orders where year(ShippedDate) = 1998 group by CustomerID having count(*) > 8 order by sum(freight) desc
--
-- select CustomerID, OrderDate from Orders where CustomerID = 'QUICK' and year(OrderDate) = 1998