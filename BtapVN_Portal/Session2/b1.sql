-- Tạo CSDL CompanyDB
CREATE DATABASE CompanyDB;

-- Sử dụng CSDL CompanyDB
USE CompanyDB;

-- Tạo bảng Employees
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    FirstName NVARCHAR(50),
    LastName NVARCHAR(50),
    HireDate DATE,
    Salary DECIMAL(10, 2)
);

-- Thêm trường Department vào bảng Employees
ALTER TABLE Employees
ADD Department NVARCHAR(50);

-- Chỉnh sửa kiểu dữ liệu của trường Salary thành decimal(10, 2)
ALTER TABLE Employees
MODIFY COLUMN Salary DECIMAL(10, 2); 