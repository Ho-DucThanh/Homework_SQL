CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName NVARCHAR(100),
    Category NVARCHAR(50),
    Price DECIMAL(10, 2),
    StockQuantity INT
);

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    OrderDate DATE,
    ProductID INT,
    Quantity INT,
    TotalAmount DECIMAL(10, 2),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

-- Thêm dữ liệu vào bảng Products
INSERT INTO Products (ProductID, ProductName, Category, Price, StockQuantity)
VALUES 
(1, 'Product A', 'A', 100.00, 50),
(2, 'Product B', 'A', 200.00, 30),
(3, 'Product C', 'B', 150.00, 20);

-- Thêm dữ liệu vào bảng Orders
INSERT INTO Orders (OrderID, OrderDate, ProductID, Quantity, TotalAmount)
VALUES 
(1, '2023-10-01', 1, 150, 0),
(2, '2023-10-02', 2, 200, 0);

-- Cập nhật giá của một sản phẩm cụ thể trong bảng Products
UPDATE Products
SET Price = 120.00
WHERE ProductID = 1;

-- Tính toán và cập nhật TotalAmount trong bảng Orders
UPDATE Orders o
SET o.TotalAmount = (
    SELECT p.Price * o.Quantity
    FROM Products p
    WHERE p.ProductID = o.ProductID
);


-- Truy vấn để lấy danh sách tất cả sản phẩm và số lượng còn lại trong kho
SELECT ProductID, ProductName, Quantity
FROM Products;

-- Truy vấn để lấy thông tin về tất cả các đơn hàng cùng với tên sản phẩm, số lượng, và tổng số tiền của từng đơn hàng
SELECT o.OrderID, o.OrderDate, p.ProductName,  o.Quantity, o.TotalAmount
FROM Orders o
INNER JOIN Products p
ON o.ProductID = p.ProductID



