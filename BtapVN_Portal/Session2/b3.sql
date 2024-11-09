-- Truy vấn tất cả nhân viên thuộc phòng ban cụ thể
SELECT * 
FROM Employees
WHERE DepartmentID IN (
    SELECT DepartmentID 
    FROM Departments 
    WHERE DepartmentName = "Phong so 1"
);

-- cách 2:
SELECT * 
FROM Employees e
INNER JOIN Departments d ON e.DepartmentID = d.DepartmentID
WHERE d.DepartmentName = "Phong so 1";


-- Cập nhật thông tin lương của một nhân viên
UPDATE Employees
SET Salary = 5000
WHERE EmployeeID = 1;

-- Xóa tất cả nhân viên có mức lương thấp hơn một giá trị nhất định
DELETE FROM Employees
WHERE Salary < 3000;
