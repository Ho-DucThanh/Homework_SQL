-- Tạo bảng Employee (Thông tin nhân viên)
CREATE TABLE Employee (
    employee_id INT PRIMARY KEY AUTO_INCREMENT, 
    `name` VARCHAR(100) NOT NULL,                
    age INT NOT NULL             
);

-- Tạo bảng Department (Thông tin bộ phận)
CREATE TABLE Department (
    department_id INT PRIMARY KEY AUTO_INCREMENT, 
    `name` VARCHAR(100) NOT NULL UNIQUE           
);

-- Tạo bảng Employee_Department (Quan hệ giữa nhân viên và bộ phận)
CREATE TABLE Employee_Department (
    employee_id INT,                            
    department_id INT,                         
    PRIMARY KEY (employee_id, department_id),    
    FOREIGN KEY (employee_id) REFERENCES Employee(employee_id),
    FOREIGN KEY (department_id) REFERENCES Department(department_id)
);

-- Tạo bảng Salary (Thông tin mức lương)
CREATE TABLE Salary (
    employee_id INT,                          
    salary DECIMAL(10, 2) NOT NULL,              
    effective_date DATE NOT NULL,              
    PRIMARY KEY (employee_id, effective_date),   
    FOREIGN KEY (employee_id) REFERENCES Employee(employee_id) 
);


-- Thêm dữ liệu vào bảng Employeee
INSERT INTO Employee (name, age) VALUES
('Nguyễn A', 30),
('Trần B', 25),
('Lê C', 28),
('Phạm D', 35),
('Hoàng E', 40);

-- Thêm dữ liệu vào bảng Department
INSERT INTO Department (name) VALUES
('Kế toán'),
('Kỹ thuật'),
('Kinh doanh'),
('Nhân sự');

-- Thêm dữ liệu vào bảng Employee_Department
INSERT INTO Employee_Department (employee_id, department_id) VALUES
(1, 1),  -- Nguyễn A làm ở Kế toán
(1, 2),  -- Nguyễn A làm ở Kỹ thuật
(2, 1),  -- Trần B làm ở Kế toán
(2, 3),  -- Trần B làm ở Kinh doanh
(3, 2),  -- Lê C làm ở Kỹ thuật
(4, 3),  -- Phạm D làm ở Kinh doanh
(5, 4),  -- Hoàng E làm ở Nhân sự
(3, 1),  -- Lê C làm ở Kế toán
(4, 1);  -- Phạm D làm ở Kế toán

-- Thêm dữ liệu vào bảng Salary
INSERT INTO Salary (employee_id, salary, effective_date) VALUES
(1, 45000.00, '2024-01-01'),
(2, 60000.00, '2024-01-01'),
(3, 70000.00, '2024-01-01'),
(4, 55000.00, '2024-01-01'),
(5, 50000.00, '2024-01-01');


-- liệt kê tất cả các nhân viên trong bộ phận có tên là "Kế toán" (mã nhân viên và tên nhân viên)
SELECT e.employee_id, e.name
FROM Employee e
JOIN Employee_Department ed ON e.employee_id = ed.employee_id
JOIN Department d ON ed.department_id = d.department_id
WHERE d.name = 'Kế toán';

-- tìm các nhân viên có mức lương lớn hơn 50,000. Kết quả trả về cần bao gồm mã nhân viên, tên nhân viên và mức lương.
SELECT e.employee_id, e.name, s.salary
FROM Employee e
JOIN Salary s ON e.employee_id = s.employee_id
WHERE s.salary > 50000;

-- hiển thị tất cả các bộ phận và số lượng nhân viên trong từng bộ phận. Kết quả trả về cần bao gồm tên bộ phận và số lượng nhân viên.
SELECT d.name AS department_name, COUNT(ed.employee_id) AS num_employees
FROM Department d
LEFT JOIN Employee_Department ed ON d.department_id = ed.department_id
GROUP BY d.name;

-- tìm ra các thành viên có mức lương cao nhất theo từng bộ phận. 
-- Kết quả trả về là một danh sách theo bất cứ thứ tự nào. 
-- Nếu có nhiều nhân viên bằng lương nhau nhưng cũng là mức lương cao nhất thì hiển thị tất cả những nhân viên đó ra.
SELECT e.employee_id, e.name, s.salary, d.name AS department_name
FROM Employee e
JOIN Salary s ON e.employee_id = s.employee_id
JOIN Employee_Department ed ON e.employee_id = ed.employee_id
JOIN Department d ON ed.department_id = d.department_id
WHERE s.salary = (
    SELECT MAX(salary)
    FROM Salary s2
    JOIN Employee_Department ed2 ON s2.employee_id = ed2.employee_id
    JOIN Department d2 ON ed2.department_id = d2.department_id
    WHERE d2.department_id = d.department_id
    GROUP BY d2.department_id
);


-- tìm các bộ phận có tổng mức lương của nhân viên vượt quá 100,000 (hoặc một mức tùy chọn khác). 
-- Kết quả trả về bao gồm tên bộ phận và tổng mức lương của bộ phận đó.
SELECT d.name AS department_name, SUM(s.salary) AS total_salary
FROM Department d
JOIN Employee_Department ed ON d.department_id = ed.department_id
JOIN Salary s ON ed.employee_id = s.employee_id
GROUP BY d.name
HAVING SUM(s.salary) > 100000;

-- liệt kê tất cả các nhân viên làm việc trong hơn 2 bộ phận khác nhau. 
-- Kết quả cần hiển thị mã nhân viên, tên nhân viên và số lượng bộ phận mà họ tham gia.
SELECT e.employee_id, e.name, COUNT(DISTINCT ed.department_id) AS num_departments
FROM Employee e
JOIN Employee_Department ed ON e.employee_id = ed.employee_id
GROUP BY e.employee_id, e.name
HAVING COUNT(DISTINCT ed.department_id) > 2;






