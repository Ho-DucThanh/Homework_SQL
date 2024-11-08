-- 1. Tìm top 3 cửa hàng có doanh thu cao nhất trong quý hiện tại
DECLARE @CurrentQuarter INT = DATEPART(QUARTER, GETDATE());
DECLARE @CurrentYear INT = DATEPART(YEAR, GETDATE());

SELECT TOP 3 
    s.StoreName, 
    SUM(sale.TotalAmount) AS TotalRevenue
FROM 
    Sales sale
JOIN 
    Stores s ON sale.StoreID = s.StoreID
WHERE 
    DATEPART(QUARTER, sale.SaleDate) = @CurrentQuarter
    AND DATEPART(YEAR, sale.SaleDate) = @CurrentYear
GROUP BY 
    s.StoreName
ORDER BY 
    TotalRevenue DESC;

-- 2. Tính mức độ đóng góp của mỗi sản phẩm vào tổng doanh thu của cửa hàng có ID là 5 trong năm ngoái
DECLARE @LastYear INT = YEAR(GETDATE()) - 1;

SELECT 
    sd.ProductID, 
    p.ProductName, 
    SUM(sd.Quantity * sd.UnitPrice) AS ProductRevenue,
    SUM(sd.Quantity * sd.UnitPrice) * 1.0 / (SELECT SUM(TotalAmount) 
                                             FROM Sales 
                                             WHERE StoreID = 5 AND YEAR(SaleDate) = @LastYear) AS ContributionPercentage
FROM 
    SalesDetails sd
JOIN 
    Sales sale ON sd.SaleID = sale.SaleID
JOIN 
    Products p ON sd.ProductID = p.ProductID
WHERE 
    sale.StoreID = 5
    AND YEAR(sale.SaleDate) = @LastYear
GROUP BY 
    sd.ProductID, 
    p.ProductName;


-- 3. Tìm danh sách khách hàng có số lượng đơn hàng và tổng chi tiêu cao nhất trong năm 2024
SELECT 
    c.CustomerID, 
    c.CustomerName,
    COUNT(sale.SaleID) AS OrderCount,
    SUM(sale.TotalAmount) AS TotalSpent
FROM 
    Sales sale
JOIN 
    Customers c ON sale.CustomerID = c.CustomerID
WHERE 
    YEAR(sale.SaleDate) = 2024
GROUP BY 
    c.CustomerID, 
    c.CustomerName
HAVING 
    SUM(sale.TotalAmount) > 10000
ORDER BY 
    TotalSpent DESC;

-- 4. Tối ưu hóa truy vấn SQL
-- 4.1: Sử dụng chỉ số (Indexes): Tạo các chỉ số (indexes) trên các cột được sử dụng trong WHERE và JOIN như SaleDate, StoreID, CustomerID, và ProductID trong các bảng Sales, SalesDetails, Stores, và Customers.
-- 4.2: Sử dụng các phép toán có điều kiện: Thay vì SUM(TotalAmount) trong phép tính phân tích tỷ lệ đóng góp, có thể tối ưu bằng cách sử dụng chỉ số (index) trên cột TotalAmount để giảm thời gian truy vấn tổng số.
-- 4.3: Sử dụng các View hoặc Indexed View (nếu có thể): Tạo một view chứa các kết quả truy vấn phụ tính toán tổng doanh thu hoặc tổng chi tiêu theo từng năm hoặc từng quý để sử dụng lại.

