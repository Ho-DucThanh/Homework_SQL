-- Tính doanh thu hàng tháng của năm trước
WITH MonthlyRevenueLastYear AS (
    SELECT 
        MONTH(SaleDate) AS Month,
        SUM(TotalAmount) AS MonthlyRevenue
    FROM 
        Sales
    WHERE 
        YEAR(SaleDate) = YEAR(GETDATE()) - 1
    GROUP BY 
        MONTH(SaleDate)
)

-- Tính doanh thu hàng tháng và dự báo cho tháng hiện tại
SELECT 
    Month,
    MonthlyRevenue AS RevenueLastYear,
    AVG(MonthlyRevenue) OVER () AS PredictedRevenueCurrentMonth
FROM 
    MonthlyRevenueLastYear
ORDER BY 
    Month;