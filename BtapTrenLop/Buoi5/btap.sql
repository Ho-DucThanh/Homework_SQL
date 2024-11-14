CREATE TABLE Customers (
	CustomerID INT Primary Key Auto_increment,
	CustomerName VARCHAR(255),
	ContactName VARCHAR(255),
	Country VARCHAR(255)
);

CREATE TABLE Orders (
	OrderID INT Primary Key Auto_increment,
	CustomerID INT,
	OrderDate DATE,
	TotalAmount DECIMAL(10, 2),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

CREATE TABLE Products (
	ProductID INT Primary Key Auto_increment,
	ProductName VARCHAR(255),
	Price DECIMAL(10, 2)
);

CREATE TABLE OrderDetails (
	OrderDetailID INT Primary Key Auto_increment,
	OrderID INT,
	ProductID INT,
	Quantity INT,
	UnitPrice DECIMAL(10, 2),
    Foreign Key (OrderID) REFERENCES Orders(OrderID),
    Foreign Key (ProductID) REFERENCES Products(ProductID)
);


CREATE VIEW tt_donhang AS
SELECT c.CustomerID , c.CustomerName, c.ContactName , o.OrderDate, o.totalAmount, p.ProductName, p.Price
FROM Orders o
INNER JOIN Customers c ON c.CustomerID = o.CustomerID;


CREATE VIEW ct_donhang AS
SELECT c.CustomerName, o.OrderID, p.ProductName, od.Quantity, od.UnitPrice, (od.Quantity * od.UnitPrice) AS totalPrice
FROM Orders o
INNER JOIN Customers c ON c.CustomerID = o.CustomerID
INNER JOIN orderdetails od ON od.OrderID = o.OrderID
INNER JOIN Products p ON p.ProductID = od.ProductID;


CREATE INDEX idx_orders_customerid ON Orders(CustomerID);

CREATE INDEX idx_orderdetails_productid ON OrderDetails(ProductID);









