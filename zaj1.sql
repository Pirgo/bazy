select CompanyName, Address from Customers

select LastName, HomePhone, Extension from Employees

select ProductName, UnitPrice from Products

select CategoryName, Description from Categories

select CompanyName, HomePage from Suppliers

select CompanyName, City, Region, PostalCode, Address from Customers where City = 'London'

select CompanyName, City, Region, PostalCode, Address from Customers where Country = 'France' or Country = 'Spain'

select ProductName, UnitPrice from Products where UnitPrice between 20.00 and 30.00

select ProductName, UnitPrice from Products where CategoryID = 6

select ProductName, UnitsInStock from Products where SupplierID = 4

select ProductName from Products where UnitsInStock = 0

