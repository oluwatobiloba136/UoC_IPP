Use NORTHWND
go
-- 1
Select * from Shippers

-- 2
Select CategoryName, Description

from Categories

-- 3

-- check the tuples of Title
Select Distinct(Title) from Employees

Select FirstName, LastName, HireDate
from Employees
where Title = 'Sales Representative'

-- 4
-- check the tuples of Title
Select Distinct(Country) from Employees

Select FirstName, LastName, HireDate
from Employees
where Title = 'Sales Representative'
and Country = 'USA'

-- 5
-- preview the Orders table
Select  top(5) * from Orders

Select * from Orders
where EmployeeID = 5

-- 6
--In the Suppliers table, show the SupplierID,
--ContactName, and ContactTitle for those Suppliers
--whose ContactTitle is not Marketing Manager.

Select SupplierID, ContactName, ContactTitle
from Suppliers
where ContactTitle != 'Marketing Manager'

-- 7
--In the products table, we’d like to see the ProductID and
--ProductName for those products where the ProductName
--includes the string “queso”
Select ProductID, ProductName
from Products
where ProductName like '%queso%'

-- 8
--Looking at the Orders table, there’s a field called
--ShipCountry. Write a query that shows the OrderID,
--CustomerID, and ShipCountry for the orders where the
--ShipCountry is either France or Belgium.

Select OrderID, CustomerID, ShipCountry
from 
Orders
where ShipCountry in ('France','Belgium')

--9
--Now, instead of just wanting to return all the orders from
--France of Belgium, we want to show all the orders from
--any Latin American country. But we don’t have a list of
--Latin American countries in a table in the Northwind
--database. So, we’re going to just use this list of Latin
--American countries that happen to be in the Orders table:
--Brazil Mexico Argentina Venezuela It doesn’t make
--sense to use multiple Or statements anymore, it would get
--too convoluted. Use the In statement.
Select OrderID, CustomerID, ShipCountry
from 
Orders
where ShipCountry in ('Brazil','Mexico','Argentina','Venezuela')

-- 10
--For all the employees in the Employees table, show the
--FirstName, LastName, Title, and BirthDate. Order the
--results by BirthDate, so we have the oldest employees
--first.
Select FirstName, LastName, Title, BirthDate
from Employees
Order by BirthDate asc

-- 11
--In the output of the query above, showing the Employees
--in order of BirthDate, we see the time of the BirthDate
--field, which we don’t want. Show only the date portion of
--the BirthDate field.

Select FirstName, LastName, Title, convert(Date,BirthDate) as Birthyear
from Employees
Order by BirthDate asc


-- 12
--Show the FirstName and LastName columns from the
--Employees table, and then create a new column called
--FullName, showing FirstName and LastName joined
--together in one column, with a space in-between.

Select FirstName, LastName, FirstName +  ' ' +  LastName as FullName
from Employees

-- 13
--In the OrderDetails table, we have the fields UnitPrice
--and Quantity. Create a new field, TotalPrice, that
--multiplies these two together. We’ll ignore the Discount
--field for now.
--In addition, show the OrderID, ProductID, UnitPrice, and
--Quantity. Order by OrderID and ProductID.

Select OrderID, ProductID, UnitPrice, Quantity, UnitPrice*Quantity as TotalPrice
from [Order Details]

-- 14
--How many customers do we have in the Customers table?
--Show one value only, and don’t rely on getting the
--recordcount at the end of a resultset.

Select count(*)
from Customers

-- 15
--Show the date of the first order ever made in the Orders
--table.

Select min(OrderDate)
from Orders

-- 16
--Show a list of countries where the Northwind company
--has customers
select top(1) * from Customers

select distinct(Country)
from Customers
where CustomerID is not null

-- 17
--Show a list of all the different values in the Customers
--table for ContactTitles. Also include a count for each
--ContactTitle.
--This is similar in concept to the previous question
--“Countries where there are customers”
--, except we now
--want a count for each ContactTitle.

Select ContactTitle, count( ContactTitle) as TotalCount
from Customers
group by ContactTitle
order by TotalCount desc

-- 18
--We’d like to show, for each product, the associated
--Supplier. Show the ProductID, ProductName, and the
--CompanyName of the Supplier. Sort by ProductID.
--This question will introduce what may be a new concept,
--the Join clause in SQL. The Join clause is used to join
--two or more relational database tables together in a
--logical way.
--Here’s a data model of the relationship between Products
--and Suppliers.

Select ProductID, ProductName, Supplier = CompanyName
from Products  p
join Suppliers  s on s.SupplierID = p.SupplierID

-- 19
--We’d like to show a list of the Orders that were made,
--including the Shipper that was used. Show the OrderID,
--OrderDate (date only), and CompanyName of the
--Shipper, and sort by OrderID.
--In order to not show all the orders (there’s more than
--800), show only those rows with an OrderID of less than
--10300.
Select OrderID, Convert(Date,OrderDate), ShipName
from Orders 
where OrderID <10300
order by OrderID

-- 20
--For this problem, we’d like to see the total number of
--products in each category. Sort the results by the total
--number of products, in descending order.
Select C.CategoryName, COUNT(P.ProductID) as nun
from Categories C
join Products P on P.CategoryID = C.CategoryID
group by C.CategoryName
order by nun desc

-- 21
--In the Customers table, show the total number of
--customers per Country and City

Select Country, City, count(*) 
from Customers
group by Country, City

