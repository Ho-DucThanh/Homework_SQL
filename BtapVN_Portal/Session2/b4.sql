CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    OrderDate DATE,
    CustomerID INT,
    TotalAmount DECIMAL(10, 2) CHECK (TotalAmount >= 0),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);




