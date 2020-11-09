SELECT buyer_name, sales.buyer_id, qty
FROM buyers, sales
WHERE buyers.buyer_id = sales.buyer_id

SELECT buyer_name, s.buyer_id, qty
FROM buyers AS b INNER JOIN sales AS s
ON b.buyer_id = s.buyer_id

SELECT buyer_name AS [b.buyer_name],
b.buyer_id AS [b.buyer_id],
s.buyer_id AS [s.buyer_id],
qty AS [s.qty]
FROM buyers AS b, sales AS s

SELECT b.buyer_name AS [b.buyer_name],
b.buyer_id AS [b.buyer_id],
s.buyer_id AS [s.buyer_id],
qty AS [s.qty]
FROM buyers AS b, sales AS s
WHERE b.buyer_name = 'Adam Barr'

SELECT b.buyer_name AS [b.buyer_name],
b.buyer_id AS [b.buyer_id],
s.buyer_id AS [s.buyer_id],
qty AS [s.qty]
FROM buyers AS b, sales AS s
WHERE s.buyer_id = b.buyer_id
AND
b.buyer_name = 'Adam Barr'

-- Napisz polecenie zwracające nazwy produktów i firmy je
-- dostarczające (baza northwind)
-- l tak aby produkty bez „dostarczycieli” i „dostarczyciele” bez
-- produktów nie pojawiali się w wyniku.

select ProductName, CompanyName
from Products as p inner join Suppliers as s
on p.SupplierID = s.SupplierID

SELECT productname, companyname
FROM products
INNER JOIN suppliers
ON products.supplierid = suppliers.supplierid

-- Napisz polecenie zwracające jako wynik nazwy klientów, którzy
-- złożyli zamówienia po 01 marca 1998 (baza northwind)
select distinct CompanyName, OrderDate
from Customers as c INNER JOIN Orders as o
on c.CustomerID = o.CustomerID
WHERE o.OrderDate > '3/1/98'

SELECT companyname, customers.customerid, orderdate
FROM customers
LEFT OUTER JOIN orders
ON customers.customerid = orders.customerid

--zadania
-- Wybierz nazwy i ceny produktów (baza northwind) o cenie
-- jednostkowej pomiędzy 20.00 a 30.00, dla każdego produktu podaj
-- dane adresowe dostawcy

select ProductName, UnitPrice, Address, City, Region, PostalCode, Phone, Fax
from Products as p INNER JOIN Suppliers as s
on p.SupplierID = s.SupplierID
where p.UnitPrice between 20 and 30

-- Wybierz nazwy produktów oraz inf. o stanie magazynu dla
-- produktów dostarczanych przez firmę ‘Tokyo Traders’
select ProductName, UnitsInStock
from Products as p INNER JOIN Suppliers as s
on p.SupplierID = s.SupplierID
where s.CompanyName = 'Tokyo Traders'

-- Czy są jacyś klienci którzy nie złożyli żadnego zamówienia w 1997
-- roku, jeśli tak to pokaż ich dane adresowe
select Address, City, Region, PostalCode, Country
from Customers LEFT OUTER JOIN Orders O on Customers.CustomerID = O.CustomerID and year(O.OrderDate) = 1997
where OrderID IS NULL

-- Wybierz nazwy i numery telefonów dostawców, dostarczających
-- produkty, których aktualnie nie ma w magazynie
select CompanyName, Phone
from Suppliers as s INNER JOIN  Products P on s.SupplierID = P.SupplierID
where P.UnitsInStock IS NULL  or P.UnitsInStock < 1

-- Napisz polecenie, które wyświetla listę dzieci będących członkami
-- biblioteki (baza library). Interesuje nas imię, nazwisko i data
-- urodzenia dziecka.

select firstname, lastname, birth_date
from member as m INNER JOIN juvenile j on m.member_no = j.member_no

-- Napisz polecenie, które podaje tytuły aktualnie wypożyczonych
-- książek
select distinct t.title
from title as t inner join loan as l
on t.title_no = l.title_no

-- Podaj informacje o karach zapłaconych za przetrzymywanie książki
-- o tytule ‘Tao Teh King’. Interesuje nas data oddania książki, ile dni
-- była przetrzymywana i jaką zapłacono karę
select fine_paid, in_date, DATEDIFF(day, in_date,due_date) as delay
from loanhist as l INNER JOIN title t on l.title_no = t.title_no
where t.title = 'Tao Teh King' and DATEDIFF(day, in_date,due_date) > 0

-- Napisz polecenie które podaje listę książek (mumery ISBN)
-- zarezerwowanych przez osobę o nazwisku: Stephen A. Graff
select isbn
from reservation r inner join member m on r.member_no = m.member_no
where firstname = 'Stephen' AND
      middleinitial = 'A' AND
      lastname = 'Graff'

USE northwind
SELECT suppliers.companyname, shippers.companyname
FROM suppliers
CROSS JOIN shippers

-- Wybierz nazwy i ceny produktów (baza northwind) o cenie
-- jednostkowej pomiędzy 20.00 a 30.00, dla każdego produktu podaj
-- dane adresowe dostawcy, interesują nas tylko produkty z kategorii
-- ‘Meat/Poultry’
select ProductName, UnitPrice, Address, City, Region, PostalCode, Country
from Products as p
INNER JOIN Suppliers S on p.SupplierID = S.SupplierID
INNER JOIN Categories C on p.CategoryID = C.CategoryID
where CategoryName='Meat/Poultry' and UnitPrice between 20 and 30

-- Wybierz nazwy i ceny produktów z kategorii ‘Confections’ dla
-- każdego produktu podaj nazwę dostawcy.

select ProductName, UnitPrice, CompanyName
from Products as p
INNER JOIN Categories C on p.CategoryID = C.CategoryID
INNER JOIN Suppliers S on p.SupplierID = S.SupplierID
where CategoryName = 'Confections'

-- Wybierz nazwy i numery telefonów klientów , którym w 1997 roku
-- przesyłki dostarczała firma ‘United Package’
select distinct C.CompanyName, C.Phone
from Customers as C
INNER JOIN Orders O on C.CustomerID = O.CustomerID
INNER JOIN Shippers S on O.ShipVia = S.ShipperID
where year(ShippedDate) = 1997 and S.CompanyName = 'United Package'

-- Wybierz nazwy i numery telefonów klientów, którzy kupowali
-- produkty z kategorii ‘Confections’
select distinct C.CompanyName, C.Phone
from Customers as C
INNER JOIN Orders O on C.CustomerID = O.CustomerID
INNER JOIN [Order Details] [O D] on O.OrderID = [O D].OrderID
INNER JOIN Products P on [O D].ProductID = P.ProductID
INNER JOIN Categories C2 on P.CategoryID = C2.CategoryID
where CategoryName = 'Confections'

-- Napisz polecenie, które wyświetla listę dzieci będących członkami
-- biblioteki (baza library). Interesuje nas imię, nazwisko, data
-- urodzenia dziecka i adres zamieszkania dziecka.
select m.firstname, m.lastname, j.birth_date, a.street, city, state, zip
from juvenile as j
inner join adult a on j.adult_member_no = a.member_no
inner join member m on a.member_no = m.member_no

SELECT firstname, middleinitial, lastname, birth_date, street, city, state, zip
FROM juvenile
JOIN member m ON juvenile.member_no = m.member_no
JOIN adult a ON a.member_no = juvenile.adult_member_no

-- Napisz polecenie, które wyświetla listę dzieci będących członkami
-- biblioteki (baza library). Interesuje nas imię, nazwisko, data
-- urodzenia dziecka, adres zamieszkania dziecka oraz imię i nazwisko
-- rodzica.
select jm.firstname, jm.lastname, j.birth_date, am.firstname, am.lastname, street, city, zip, state
from juvenile as j
inner join member as jm on j.member_no = jm.member_no
inner join adult as a on j.adult_member_no = a.member_no
inner join member as am on am.member_no = a.member_no


USE joindb
SELECT a.buyer_id AS buyer1, a.prod_id
,b.buyer_id AS buyer2
FROM sales AS a
INNER JOIN sales AS b
ON a.prod_id = b.prod_id
where a.buyer_id < b.buyer_id

-- Napisz polecenie, które wyświetla pracowników oraz ich
-- podwładnych (baza northwind)
USE Northwind
select m.FirstName, m.LastName, s.FirstName as S, s.LastName
from Employees as m
inner join Employees as s on m.EmployeeID = s.ReportsTo

-- Napisz polecenie, które wyświetla pracowników, którzy nie mają
-- podwładnych (baza northwind)
USE Northwind
select m.FirstName, m.LastName
from Employees as m
left join Employees as s on m.EmployeeID = s.ReportsTo
where s.ReportsTo is null

-- Napisz polecenie, które wyświetla adresy członków biblioteki, którzy
-- mają dzieci urodzone przed 1 stycznia 1996
USE library
select distinct a.member_no,a.street, a.city, a.state, a.zip
from adult as a
inner join juvenile j on a.member_no = j.adult_member_no
where j.birth_date <  '1996-01-01'

-- Napisz polecenie, które wyświetla adresy członków biblioteki, którzy
-- mają dzieci urodzone przed 1 stycznia 1996. Interesują nas tylko
-- adresy takich członków biblioteki, którzy aktualnie nie przetrzymują
-- książek.
USE library
select distinct a.member_no,a.street, a.city, a.state, a.zip
from adult as a
inner join member as m on a.member_no = m.member_no
inner join juvenile j on a.member_no = j.adult_member_no
left join loanhist l on  m.member_no = l.member_no
where j.birth_date <  '1996-01-01' and (l.member_no is NULL or in_date < GETDATE())


USE northwind
SELECT (firstname + ' ' + lastname) AS name
,city, postalcode
FROM employees
UNION
SELECT companyname, city, postalcode
FROM customers


-- Napisz polecenie które zwraca imię i nazwisko (jako pojedynczą
-- kolumnę – name), oraz informacje o adresie: ulica, miasto, stan kod
-- (jako pojedynczą kolumnę – address) dla wszystkich dorosłych
-- członków biblioteki
--CONCAT_WS(' ', ...)
USE library
select (firstname + ' ' + lastname) as name, (street + ' ' + city + ' ' + state + ' ' + zip) as adress
from member inner join adult a on member.member_no = a.member_no

-- Napisz polecenie, które zwraca: isbn, copy_no, on_loan, title,
-- translation, cover, dla książek o isbn 1, 500 i 1000. Wynik posortuj
-- wg ISBN
use library
select c.isbn, c.copy_no, c.on_loan, t.title, i.translation, i.cover
from title as t
inner join copy c on t.title_no = c.title_no
inner join item i on i.title_no = t.title_no
where c.isbn = 1 or c.isbn = 500 or c.isbn = 1000
order by c.isbn


-- Napisz polecenie które zwraca o użytkownikach biblioteki o nr 250,
-- 342, i 1675 (dla każdego użytkownika: nr, imię i nazwisko członka
-- biblioteki), oraz informację o zarezerwowanych książkach (isbn,
-- data)
select m.member_no, firstname, lastname, isbn, log_date
from member as m
left join  reservation r2 on m.member_no = r2.member_no
where m.member_no = 250 or m.member_no = 342 or m.member_no = 1675

-- Podaj listę członków biblioteki mieszkających w Arizonie (AZ) mają
-- więcej niż dwoje dzieci zapisanych do biblioteki
select distinct m.member_no, m.firstname, m.lastname
from member as m
inner join adult a on m.member_no = a.member_no
inner join juvenile j on a.member_no = j.adult_member_no
where a.state = 'AZ'
group by m.member_no, m.firstname, m.lastname
having count(*) > 2

-- Podaj listę członków biblioteki mieszkających w Arizonie (AZ) którzy
-- mają więcej niż dwoje dzieci zapisanych do biblioteki oraz takich
-- którzy mieszkają w Kaliforni (CA) i mają więcej niż troje dzieci
-- zapisanych do biblioteki

select distinct m.member_no, m.firstname, m.lastname
from member as m
inner join adult a on m.member_no = a.member_no
inner join juvenile j on a.member_no = j.adult_member_no
where a.state = 'AZ'
group by m.member_no, m.firstname, m.lastname
having count(*) > 2
union
select distinct m.member_no, m.firstname, m.lastname
from member as m
inner join adult a on m.member_no = a.member_no
inner join juvenile j on a.member_no = j.adult_member_no
where a.state = 'CA'
group by m.member_no, m.firstname, m.lastname
having count(*) > 2


