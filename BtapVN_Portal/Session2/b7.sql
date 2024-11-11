CREATE TABLE Sales (
    SaleID INT PRIMARY KEY AUTO_INCREMENT,
    SaleDate DATE,
    CustomerID INT,
    TotalAmount DECIMAL(10, 2)  
);

CREATE TABLE Products (
    ProductID INT PRIMARY KEY AUTO_INCREMENT,
    ProductName VARCHAR(255),
    Category VARCHAR(255),
    Price DECIMAL(10, 2)
);

CREATE TABLE SaleDetails (
    SaleDetailID INT PRIMARY KEY AUTO_INCREMENT,
    SaleID INT,
    ProductID INT,
    Quantity INT,
    UnitPrice DECIMAL(10, 2),
    FOREIGN KEY (SaleID) REFERENCES Sales(SaleID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

-- tổng doanh thu theo danh mục sản phẩm trong quý gần nhất
WITH QuarterlySales AS (
    SELECT 
        P.Category,
        SUM(SD.Quantity * SD.UnitPrice) AS TotalRevenue
    FROM 
        Sales S
        JOIN SaleDetails SD ON S.SaleID = SD.SaleID
        JOIN Products P ON SD.ProductID = P.ProductID
    WHERE 
        S.SaleDate >= DATEADD(QUARTER, DATEDIFF(QUARTER, 0, GETDATE()) - 1, 0)
        AND S.SaleDate < DATEADD(QUARTER, DATEDIFF(QUARTER, 0, GETDATE()), 0)
    GROUP BY 
        P.Category
)

SELECT TOP 1 
    Category,
    TotalRevenue
FROM 
    QuarterlySales
ORDER BY 
    TotalRevenue DESC;


-- danh mục sản phẩm nào có doanh thu cao nhất
SELECT TOP 1 
    Category,
    TotalRevenue
FROM 
    QuarterlySales
ORDER BY 
    TotalRevenue DESC;

