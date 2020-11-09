select * from Products

 where categoryid in (select categoryid from categories

 where CategoryName = 'Meat/Poultry')


declare @id INT

 set @id = (select categoryid from categories

 where CategoryName = 'Meat/Poultry')

select * from Products

 where categoryid = @id


select Products.* from Products join Categories on Categories.CategoryID = Products.CategoryID
where CategoryName = 'Meat/Poultry'

select Products.* from Products, Categories
where Categories.CategoryID = Products.CategoryID
and CategoryName = 'Meat/Poultry'

select * from Products where QuantityPerUnit LIKE '%bottle%'

select Title from Employees where LastName LIKE '[BL]%'

select Title from Employees where LastName LIKE '[B-L]%'

select CategoryName from Categories where Description LIKE '%,%'

select * from Customers where CompanyName LIKE '%Store%'

-- Napisz instrukcjęselecttak aby wybrać numer zlecenia, datęzamówienia,
-- numer klienta dla wszystkich niezrealizowanych jeszcze zleceń,
--dla których krajem odbiorcy jest Argentyna
Select OrderID, OrderDate, CustomerID
FROM Orders
WHERE ShippedDate IS NULL AND [ShipCountry]='Argentina'

Select OrderID, OrderDate, CustomerID
FROM Orders
WHERE ShippedDate IS NULL OR ShippedDate > GETDATE()

select productid, ProductName, UnitPrice from Products order by UnitPrice DESC

select CompanyName, Country from Customers ORDER BY Country, ContactName

select CompanyName, Country from Customers where Country in ('Italy', 'Japan') ORDER BY Country, CompanyName

--Napisz polecenie, które oblicza wartość każdej pozycji zamówienia o numerze 10250
select UnitPrice, Quantity, Discount, round(UnitPrice*Quantity*(1-Discount),2) as 'Res' from [Order Details] where OrderID = 10250

/*Napisz polecenie które dla każdego dostawcy (supplier) pokaże
pojedynczą kolumnę zawierającą nr telefonu i nr faksu w formacie
(numer telefonu i faksu mają być oddzielone przecinkiem)*/
select CompanyName, Phone + ', ' + Fax as Contact from Suppliers where Phone is not null and Fax is not null