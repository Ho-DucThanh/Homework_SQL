    CREATE TABLE Customers (
        CustomerID INT PRIMARY KEY, 
        FirstName VARCHAR(50), 
        LastName VARCHAR(50), 
        Email VARCHAR(100)
    );

    CREATE TABLE Products (
        ProductID INT PRIMARY KEY, 
        ProductName VARCHAR(100), 
        Price DECIMAL(10, 2)
    );

    CREATE TABLE Orders (
        OrderID INT PRIMARY KEY, 
        CustomerID INT, 
        OrderDate DATE, 
        TotalAmount DECIMAL(10, 2)
        FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
    );

    CREATE TABLE Promotions (
        PromotionID INT PRIMARY KEY, 
        PromotionName VARCHAR(100), 
        DiscountPercentage DECIMAL(5, 2)
    );

    CREATE TABLE Sales (
        SaleID INT PRIMARY KEY, 
        OrderID INT, 
        SaleDate DATE, 
        SaleAmount DECIMAL(10, 2),
        FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
    );

    ALTER TABLE Orders ADD FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID);
    ALTER TABLE Sales ADD FOREIGN KEY (OrderID) REFERENCES Orders(OrderID);
    ALTER TABLE Promotions MODIFY COLUMN PromotionID INT AUTO_INCREMENT;


    -- thêm chỉ số vào một số cột để cải thiện hiệu suất truy vấn.
    CREATE INDEX idx_orders_customerid ON Orders(CustomerID);
    CREATE INDEX idx_sales_orderid ON Sales(OrderID);
    CREATE INDEX idx_sales_saledate ON Sales(SaleDate);
    CREATE INDEX idx_sales_saleamount ON Sales(SaleAmount);
    CREATE INDEX idx_promotions_discountpercentage ON Promotions(DiscountPercentage);

    -- Insert dữ liệu vào bảng Customers
    INSERT INTO Customers (CustomerID, FirstName, LastName, Email) VALUES
    (1, 'John', 'Doe', 'john.doe@example.com'),
    (2, 'Jane', 'Smith', 'jane.smith@example.com'),
    (3, 'Alice', 'Brown', 'alice.brown@example.com'),
    (4, 'Bob', 'Taylor', 'bob.taylor@example.com'),
    (5, 'Charlie', 'Johnson', 'charlie.johnson@example.com');

    -- Insert dữ liệu vào bảng Orders
    INSERT INTO Orders (OrderID, CustomerID, OrderDate, TotalAmount) VALUES
    (1, 1, '2024-07-10', 2500.00),
    (2, 2, '2024-07-12', 1800.00),
    (3, 3, '2024-07-15', 900.00),
    (4, 4, '2024-07-18', 300.00),
    (5, 5, '2024-07-20', 500.00);

    -- Insert dữ liệu vào bảng Promotions
    INSERT INTO Promotions (PromotionID, PromotionName, DiscountPercentage) VALUES
    (1, 'Summer Sale', 15.00),
    (2, 'Black Friday', 30.00),
    (3, 'Holiday Discount', 20.00),
    (4, 'New Year Promo', 25.00),
    (5, 'Special Offer', 10.00);


-- Tạo Stored Procedure:
DELIMITER $$
CREATE PROCEDURE CalculateMonthlyRevenueAndApplyPromotion(IN monthYear VARCHAR(255), IN revenueThreshold DECIMAL(10, 2))
BEGIN
	INSERT INTO promotions (PromotionName, DiscountPercentage)
	SELECT 
        'Duc Thanh giam gia' AS PromotionName,
        15.00 AS DiscountPercentage 
    FROM Customers c
    INNER JOIN Orders o ON o.customerID = c.customerID
    WHERE DATE_FORMAT(o.OrderDate, '%Y-%m') = monthYear
    GROUP BY c.CustomerID
    HAVING SUM(o.totalAmount) > revenueThreshold;
END $$
DELIMITER ;

CALL CalculateMonthlyRevenueAndApplyPromotion('2024-07', 5000);

SELECT * FROM promotions;










