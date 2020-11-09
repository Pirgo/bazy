-- Dla każdego zamówienia podaj łączną liczbę zamówionych
-- jednostek towaru oraz nazwę klienta.
select OD.OrderID, SUM(Quantity), companyname
from [Order Details] as OD
inner join Orders O on OD.OrderID = O.OrderID
inner join Customers C on O.CustomerID = C.CustomerID
group by OD.OrderID, CompanyName

-- Zmodyfikuj poprzedni przykład, aby pokazać tylko takie zamówienia,
-- dla których łączna liczbę zamówionych jednostek jest większa niż
-- 250
select OD.OrderID, SUM(Quantity), companyname
from [Order Details] as OD
inner join Orders O on OD.OrderID = O.OrderID
inner join Customers C on O.CustomerID = C.CustomerID
group by OD.OrderID, CompanyName
having sum(Quantity) > 250

-- Dla każdego zamówienia podaj łączną wartość tego zamówienia oraz
-- nazwę klienta.
select OD.OrderID, SUM(cast(UnitPrice*Quantity*(1-Discount) as decimal(10,2))), companyname
from [Order Details] as OD
inner join Orders O on OD.OrderID = O.OrderID
inner join Customers C on O.CustomerID = C.CustomerID
group by OD.OrderID, CompanyName

-- Zmodyfikuj poprzedni przykład, aby pokazać tylko takie zamówienia,
-- dla których łączna liczba jednostek jest większa niż 250.
select OD.OrderID, SUM(cast(UnitPrice*Quantity*(1-Discount) as decimal(10,2))), companyname
from [Order Details] as OD
inner join Orders O on OD.OrderID = O.OrderID
inner join Customers C on O.CustomerID = C.CustomerID
group by OD.OrderID, CompanyName
having sum(Quantity) > 250

-- Zmodyfikuj poprzedni przykład tak żeby dodać jeszcze imię i
-- nazwisko pracownika obsługującego zamówienie
select OD.OrderID, SUM(cast(UnitPrice*Quantity*(1-Discount) as decimal(10,2))), companyname, e.FirstName, e.LastName
from [Order Details] as OD
inner join Orders O on OD.OrderID = O.OrderID
inner join Customers C on O.CustomerID = C.CustomerID
inner join Employees as e on O.EmployeeID = e.EmployeeID
group by e.FirstName, companyname, OD.OrderID, e.LastName
having sum(Quantity) > 250

-- Dla każdej kategorii produktu (nazwa), podaj łączną liczbę
-- zamówionych przez klientów jednostek towarów z tek kategorii.
select sum(quantity), CategoryName
from Categories as c
inner join Products P on c.CategoryID = P.CategoryID
inner join [Order Details] [O D] on P.ProductID = [O D].ProductID
group by CategoryName

-- Dla każdej kategorii produktu (nazwa), podaj łączną wartość
-- zamówionych przez klientów jednostek towarów z tek kategorii.
select sum(cast([O D].UnitPrice*Quantity*(1-Discount) as decimal(10,2))), CategoryName
from Categories as c
inner join Products P on c.CategoryID = P.CategoryID
inner join [Order Details] [O D] on P.ProductID = [O D].ProductID
group by CategoryName

-- Posortuj wyniki w zapytaniu z poprzedniego punktu wg:
-- a) łącznej wartości zamówień
-- b) łącznej liczby zamówionych przez klientów jednostek towarów.
select sum(cast([O D].UnitPrice*Quantity*(1-Discount) as decimal(10,2))), CategoryName
from Categories as c
inner join Products P on c.CategoryID = P.CategoryID
inner join [Order Details] [O D] on P.ProductID = [O D].ProductID
group by CategoryName
order by sum(cast([O D].UnitPrice*Quantity*(1-Discount) as decimal(10,2)))

select sum(quantity), CategoryName
from Categories as c
inner join Products P on c.CategoryID = P.CategoryID
inner join [Order Details] [O D] on P.ProductID = [O D].ProductID
group by CategoryName
order by sum(quantity)

-- Dla każdego zamówienia podaj jego wartość uwzględniając opłatę za
-- przesyłkę
select OD.OrderID, (sum(cast(UnitPrice*Quantity*(1-Discount) as decimal(10,2))) + sum(cast(Freight as decimal(10,2))))
from [Order Details] as OD
inner join Orders O on OD.OrderID = O.OrderID
group by OD.OrderID


-- Dla każdego przewoźnika (nazwa) podaj liczbę zamówień które
-- przewieźli w 1997r
select CompanyName, COUNT(ShipVia)
from Shippers as s
inner join Orders O on s.ShipperID = O.ShipVia
where year(O.ShippedDate) = 1997
group by CompanyName

-- Który z przewoźników był najaktywniejszy (przewiózł największą
-- liczbę zamówień) w 1997r, podaj nazwę tego przewoźnika
select TOP 1 with ties CompanyName, COUNT(ShipVia)
from Shippers as s
inner join Orders O on s.ShipperID = O.ShipVia
where year(O.ShippedDate) = 1997
group by CompanyName
order by COUNT(ShipVia) desc

-- Dla każdego pracownika (imię i nazwisko) podaj łączną wartość
-- zamówień obsłużonych przez tego pracownika
select e.FirstName, e.LastName, SUM((cast(UnitPrice*Quantity*(1-Discount) as decimal(10,2))))
from Employees as e
inner join Orders O on e.EmployeeID = O.EmployeeID
inner join [Order Details] as OD on O.OrderID = OD.OrderID
group by e.FirstName, e.LastName

-- Który z pracowników obsłużył największą liczbę zamówień w 1997r,
-- podaj imię i nazwisko takiego pracownika
select top 1 e.FirstName, e.LastName, COUNT(*)
from Employees as e
inner join Orders O on e.EmployeeID = O.EmployeeID
where year(O.OrderDate) = 1997
group by e.FirstName, e.LastName
order by COUNT(*) desc

-- Który z pracowników obsłużył najaktywniejszy (obsłużył zamówienia
-- o największej wartości) w 1997r, podaj imię i nazwisko takiego
-- pracownika
select top 1 e.FirstName, e.LastName, sum(cast([O D].UnitPrice*Quantity*(1-Discount) as decimal(10,2)))
from Employees as e
inner join Orders O on e.EmployeeID = O.EmployeeID
inner join [Order Details] [O D] on O.OrderID = [O D].OrderID
where year(O.OrderDate) = 1997
group by e.FirstName, e.LastName
order by COUNT(*) desc


-- Dla każdego pracownika (imię i nazwisko) podaj łączną wartość
-- zamówień obsłużonych przez tego pracownika
select e.firstname, e.LastName, cast(sum(od.UnitPrice*od.Quantity*(1-od.Discount)) as decimal(10,2))
from Employees as e
left join Employees as sub
on sub.ReportsTo = e.EmployeeID
join Orders as o
on o.EmployeeID = e.EmployeeID
join [Order Details] as od
on od.OrderID = o.OrderID
where sub.ReportsTo is not null
group by e.firstname, e.LastName

select e.firstname, e.LastName, cast(sum(od.UnitPrice*od.Quantity*(1-od.Discount)) as decimal(10,2))
from Employees as e
left join Employees as sub
on sub.ReportsTo = e.EmployeeID
join Orders as o
on o.EmployeeID = e.EmployeeID
join [Order Details] as od
on od.OrderID = o.OrderID
where sub.ReportsTo is null
group by e.firstname, e.LastName