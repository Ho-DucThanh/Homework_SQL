-- Hiển thị tất cả thông tin của kiến trúc sư "le thanh tung"
SELECT *
FROM architect
WHERE name = 'le thanh tung';

-- Hiển thị tên, năm sinh các công nhân có chuyên môn hàn hoặc điện
SELECT `name`, `birthday` 
FROM `worker`
WHERE `skill` IN('han', 'dien');

--Hiển thị tên các công nhân có chuyên môn hàn hoặc điện và năm sinh lớn hơn 1948
SELECT `name`, `birthday` 
FROM `worker`
WHERE `skill` IN('han', 'dien') AND birthday > 1948;

-- Hiển thị những công nhân bắt đầu vào nghề khi dưới 20 (birthday + 20 > year)
SELECT * FROM `worker`
WHERE `birthday` + 20 > `year`;

-- Hiển thị những công nhân có năm sinh 1945, 1940, 1948 (Bằng 2 cách)
-- C1:
SELECT * FROM `worker`
WHERE `birthday` IN(1945, 1940, 1948);

-- C2:
SELECT *
FROM `worker`
WHERE `birthday` = 1945 
   OR `birthday` = 1940 
   OR `birthday` = 1948;
   
-- Tìm những công trình có chi phí đầu tư từ 200 đến 500 triệu đồng (Bằng 2 cách)
-- C1:
SELECT * FROM `building`
WHERE cost BETWEEN 200000000 AND 500000000;

-- C2:
SELECT * FROM building
WHERE cost >= 200000000 AND cost <= 500000000;

-- Tìm kiếm những kiến trúc sư có họ là nguyen: % chuỗi
SELECT * FROM `architect`
WHERE `name` LIKE 'nguyen%';

-- Tìm kiếm những kiến trúc sư có tên đệm là anh
SELECT * FROM `architect`
WHERE `name` LIKE '%anh%';

-- Tìm kiếm những kiến trúc sư có tên bắt đầu th và có 3 ký tự
SELECT *
FROM architect
WHERE `name` LIKE '%th_';

-- Tìm chủ thầu không có phone
SELECT *
FROM contractor
WHERE phone IS NULL;






   







