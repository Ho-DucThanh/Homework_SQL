-- Hiển thị toàn bộ nội dung của bảng Architect
SELECT * FROM `architect`;

-- Hiển thị danh sách gồm họ tên và giới tính của kiến trúc sư
SELECT `name`, `sex` FROM `architect`;

-- Hiển thị những năm sinh có thể có của các kiến trúc sư
SELECT DISTINCT `birthday` FROM `architect`;

-- Hiển thị danh sách các kiến trúc sư (họ tên và năm sinh) (giá trị năm sinh tăng dần)
SELECT `name`, `birthday`
FROM `architect`
ORDER BY `birthday` ASC;

-- Hiển thị danh sách các kiến trúc sư (họ tên và năm sinh) (giá trị năm sinh giảm dần)
SELECT `name`, `birthday`
FROM `architect`
ORDER BY `birthday` DESC;

-- Hiển thị danh sách các công trình có chi phí từ thấp đến cao. 
-- Nếu 2 công trình có chi phí bằng nhau sắp xếp tên thành phố theo bảng chữ cái building
SELECT * FROM `building`
ORDER BY `cost` ASC, `city` ASC;








