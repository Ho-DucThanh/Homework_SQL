-- Tạo bảng
CREATE TABLE `Customers` (
    CustomerID INT PRIMARY KEY AUTO_INCREMENT,
    CustomerName NVARCHAR(100),
    Email NVARCHAR(100),
    Phone NVARCHAR(15)
);

CREATE TABLE `Orders` (
    OrderID INT PRIMARY KEY AUTO_INCREMENT,
    OrderDate DATE,
    CustomerID INT,
    FOREIGN KEY (CustomerID) REFERENCES `Customers`(CustomerID)
);

CREATE TABLE `OrderDetails` (
    OrderDetailID INT PRIMARY KEY AUTO_INCREMENT,
    OrderID INT,
    ProductID INT,
    Quantity INT,
    UnitPrice DECIMAL(10, 2),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

-- Thêm dữ liệu
INSERT INTO Customers (CustomerName, Email, Phone)
VALUES ('Nguyen Van A', 'nguyenvana@example.com', '0123456789'),
       ('Tran Thi B', 'tranthib@example.com', '0987654321');

INSERT INTO Orders (OrderDate, CustomerID)
VALUES ('2024-11-01', 1),
       ('2024-11-02', 2),
       ('2024-11-03', 1);

INSERT INTO OrderDetails (OrderID, ProductID, Quantity, UnitPrice)
VALUES (1, 1, 2, 100.00),    -- Đơn hàng 1, sản phẩm 1
       (1, 2, 1, 200.00),    -- Đơn hàng 1, sản phẩm 2
       (2, 1, 3, 100.00),    -- Đơn hàng 2, sản phẩm 1
       (2, 3, 2, 150.00),    -- Đơn hàng 2, sản phẩm 3
       (3, 2, 4, 200.00);    -- Đơn hàng 3, sản phẩm 2

-- Cập nhật dữ liệu
UPDATE Customers
SET Phone = '0123987654'
WHERE CustomerName = 'Nguyen Van A';

-- Xóa tất cả các đơn hàng của khách hàng không còn hoạt động
DELETE FROM Orders
WHERE CustomerID NOT IN (SELECT CustomerID FROM Customers);

-- Truy vấn dữ liệu
SELECT c.CustomerID,
       c.CustomerName,
       COUNT(o.OrderID) AS TotalOrders
FROM Customers c
LEFT JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerID, c.CustomerName;

-- Truy vấn chi tiết đơn hàng
-- lấy danh sách tất cả khách hàng cùng với tổng số đơn hàng mà họ đã đặt.
SELECT od.OrderID,
       p.ProductName,
       od.Quantity,
       (od.Quantity * od.UnitPrice) AS TotalAmount
FROM OrderDetails od
JOIN Products p ON od.ProductID = p.ProductID
GROUP BY od.OrderID, p.ProductName, od.Quantity, od.UnitPrice;











