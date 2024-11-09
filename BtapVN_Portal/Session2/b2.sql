CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName NVARCHAR(100),
    Category NVARCHAR(50),
    Price DECIMAL(10, 2),
    StockQuantity INT
);

INSERT INTO Products (ProductID, ProductName, Category, Price, StockQuantity)
VALUES 
    (1, 'Product A', 'Category 1', 100.00, 50),             
    (2, 'Product B', 'Category 2', 150.00, 30),
    (3, 'Product C', 'Category 3', 200.00, 20);



