-- Wybierz nazwy i numery telefonów klientów , którym w 1997 roku
-- przesyłki dostarczała firma United Package.
select CompanyName, Phone from Customers as c
where EXISTS(select ShippedDate from Orders as o
            where c.CustomerID = o.CustomerID and year(o.ShippedDate) = 1997 and EXISTS(select * from  Shippers as s
                where s.ShipperID = o.ShipVia and s.CompanyName = 'United Package'))


-- Wybierz nazwy i numery telefonów klientów, którzy kupowali
-- produkty z kategorii Confections..
select * from Categories
select distinct CompanyName, Phone from Customers as c
    inner join Orders O on c.CustomerID = O.CustomerID
        inner join [Order Details] [O D] on O.OrderID = [O D].OrderID
            inner join Products P on [O D].ProductID = P.ProductID
                inner join Categories C2 on P.CategoryID = C2.CategoryID
                    and C2.CategoryName = 'Confections'

-- Wybierz nazwy i numery telefonów klientów, którzy nie kupowali
-- produktów z kategorii Confections..
select distinct cus2.CompanyName, cus2.Phone from Customers as c
    inner join Orders O on c.CustomerID = O.CustomerID
        inner join [Order Details] [O D] on O.OrderID = [O D].OrderID
            inner join Products P on [O D].ProductID = P.ProductID
                inner join Categories C2 on P.CategoryID = C2.CategoryID
                    and C2.CategoryName = 'Confections'
                    right join Customers as cus2 on cus2.CustomerID = c.CustomerID where c.CustomerID is null

select c.CompanyName, c.Phone from Customers as c
where not EXISTS(select o.CustomerID from Orders as o
    where o.CustomerID = c.CustomerID and EXISTS(
        select od.ProductID from [Order Details] as od where o.OrderID = od.OrderID and EXISTS(
            select p.productid from Products as p where  p.ProductID = od.ProductID and EXISTS(
                select c2.categoryid from Categories as c2 where  p.CategoryID = c2.CategoryID and c2.CategoryName = 'Confections'
                )
            )
        ))

-- Dla każdego produktu podaj maksymalną liczbę zamówionych
-- jednostek
select productid, max(quantity)
from [order details]
group by productid
order by productid

select p.ProductName,(
    select max(quantity) from [Order Details] as od
    where p.ProductID = od.ProductID
    )
from Products as p

-- Podaj wszystkie produkty których cena jest mniejsza niż średnia
-- cena produktu
select p.ProductName, p.UnitPrice from  Products as p
where p.UnitPrice <(select AVG(UnitPrice) from Products)

-- Podaj wszystkie produkty których cena jest mniejsza niż średnia
-- cena produktu danej kategorii
select p.ProductName, p.UnitPrice from Products as p
where p.UnitPrice < (select avg(UnitPrice) from Products as p2 where p.CategoryID = p2.CategoryID)

-- Dla każdego produktu podaj jego nazwę, cenę, średnią cenę
-- wszystkich produktów oraz różnicę między ceną produktu a
-- średnią ceną wszystkich produktów

select p.ProductName, p.UnitPrice, (
    (select AVG(UnitPrice) from Products)
    ) as 'avg', p.UnitPrice - (select AVG(UnitPrice) from Products) as diff from Products as p

-- Dla każdego produktu podaj jego nazwę kategorii, nazwę produktu,
-- cenę, średnią cenę wszystkich produktów danej kategorii oraz
-- różnicę między ceną produktu a średnią ceną wszystkich
-- produktów danej kategorii


select p.ProductName, p.UnitPrice, (
    select CategoryName from Categories as c where p.CategoryID = c.CategoryID) as category, (
        select AVG(p2.UnitPrice) from Products as p2 where p.CategoryID = p2.CategoryID)as avg,
            (p.UnitPrice - (select AVG(p2.UnitPrice) from Products as p2 where p2.CategoryID = p.CategoryID))
from Products as p

-- Podaj łączną wartość zamówienia o numerze 1025 (uwzględnij
-- cenę za przesyłkę)
select sum((UnitPrice * Quantity) * (1-Discount)) + (
    select Freight from Orders where OrderID = 10250
    ) from [Order Details]
where OrderID = 10250

-- Podaj łączną wartość zamówień każdego zamówienia (uwzględnij
-- cenę za przesyłkę)
SELECT O.OrderID, O.Freight + (SELECT
SUM(OD.UnitPrice*OD.Quantity*(1-OD.Discount))
FROM [Order Details] AS OD
WHERE OD.OrderID = O.OrderID
GROUP BY OD.OrderID)
FROM Orders AS O

-- Czy są jacyś klienci którzy nie złożyli żadnego zamówienia w 1997
-- roku, jeśli tak to pokaż ich dane adresowe
select c.Address from  Customers as c
where c.CustomerID not in(
    select o.CustomerID from Orders as o
    where year(o.OrderDate) = 1997
    )

-- Podaj produkty kupowane przez więcej niż jednego klienta
select P.ProductName, count(*)
from Products as p
inner join [Order Details] od on od.ProductID = p.ProductID
inner join Orders O on od.OrderID = O.OrderID
inner join Customers C on O.CustomerID = C.CustomerID
group by p.ProductName
having count(*) > 1;

-- Dla każdego pracownika (imię i nazwisko) podaj łączną wartość
-- zamówień obsłużonych przez tego pracownika (przy obliczaniu
-- wartości zamówień uwzględnij cenę za przesyłkę_
SELECT e.FirstName + ' ' + e.LastName AS 'name', (
 SELECT SUM(OD.UnitPrice*od.quantity*(1-od.Discount))
 from Orders AS O
 INNER JOIN [Order Details] as OD ON O.OrderID = OD.OrderID
 WHERE e.EmployeeID = O.EmployeeID
 ) + (
 SELECT sum(O.Freight)
 from Orders as o
 WHERE o.EmployeeID = e.EmployeeID
 )
FROM Employees AS e


-- Który z pracowników obsłużył najaktywniejszy (obsłużył
-- zamówienia o największej wartości) w 1997r, podaj imię i nazwisko
-- takiego pracownika
SELECT top 1  e.FirstName + ' ' + e.LastName AS 'name', (
 SELECT SUM(OD.UnitPrice*od.quantity*(1-od.Discount))
 from Orders AS O
 INNER JOIN [Order Details] as OD ON O.OrderID = OD.OrderID
 WHERE e.EmployeeID = O.EmployeeID and year(OrderDate) = 1997
 ) + (
 SELECT sum(O.Freight)
 from Orders as o
 WHERE o.EmployeeID = e.EmployeeID
 ) as res
FROM Employees AS e
order by res desc


