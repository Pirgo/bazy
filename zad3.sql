-- Napisz polecenie, które oblicza wartość sprzedaży dla każdego
-- zamówienia w tablicy order details i zwraca wynik posortowany
-- w malejącej kolejności (wg wartości sprzedaży).
select OrderID, SUM(cast(UnitPrice*Quantity*(1-Discount) as decimal(10,2)))  as res from [Order Details]
group by OrderID
order by res desc

-- Zmodyfikuj zapytanie z poprzedniego punktu, tak aby zwracało
-- pierwszych 10 wierszy
select TOP 10 with ties OrderID, SUM(cast(UnitPrice*Quantity*(1-Discount) as decimal(10,2)))  as res from [Order Details]
group by OrderID
order by res desc

-- Podaj liczbę zamówionych jednostek produktów dla
-- produktów, dla których productid < 3
select productid, SUM(Quantity) as quantity from [Order Details]
where ProductID < 3
group by productid

-- Zmodyfikuj zapytanie z poprzedniego punktu, tak aby podawało
-- liczbę zamówionych jednostek produktu dla wszystkich
-- produktów
select productid, SUM(Quantity) as quantity from [Order Details]
group by productid
order by ProductID

-- Podaj nr zamówienia oraz wartość zamówienia, dla zamówień,
-- dla których łączna liczba zamawianych jednostek produktów
-- jest > 250
select OrderID, SUM(cast(UnitPrice*Quantity*(1-Discount) as decimal(10,2)))  as res from [Order Details]
group by OrderID
having sum(Quantity) > 250

-- Dla każdego pracownika podaj liczbę obsługiwanych przez
-- niego zamówień
select EmployeeID, count(*) from Orders
group by EmployeeID

-- Dla każdego spedytora/przewoźnika podaj wartość "opłata za
-- przesyłkę" przewożonych przez niego zamówień
select ShipVia, sum(Freight) from Orders
group by ShipVia

-- Dla każdego spedytora/przewoźnika podaj wartość "opłata za
-- przesyłkę" przewożonych przez niego zamówień w latach o
-- 1996 do 1997
select ShipVia, sum(Freight) from Orders
where year(ShippedDate) >= 1996 and year(ShippedDate) <= 1997
group by ShipVia

-- Dla każdego pracownika podaj liczbę obsługiwanych przez
-- niego zamówień z podziałem na lata i miesiące
select EmployeeID, year(OrderDate) as year, month(OrderDate) as month, count(*) from Orders
group by EmployeeID, year(OrderDate), month(OrderDate)
with rollup

-- Dla każdej kategorii podaj maksymalną i minimalną cenę
-- produktu w tej kategorii
select CategoryID, min(UnitPrice) as min, max(UnitPrice) as max from Products
group by CategoryID