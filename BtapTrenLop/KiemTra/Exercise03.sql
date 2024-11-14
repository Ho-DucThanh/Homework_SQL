-- Hiển thị thông tin công trình có chi phí cao nhất
SELECT * FROM building
WHERE cost = (SELECT MAX(cost) FROM building);

-- Hiển thị thông tin công trình có chi phí lớn hơn tất cả các công trình được xây dựng ở Cần Thơ
SELECT * FROM building
WHERE cost > ALL(SELECT MAX(cost) FROM building WHERE city = 'can tho');

-- Hiển thị thông tin công trình có chi phí lớn hơn một trong các công trình được xây dựng ở Cần Thơ
SELECT * FROM building
WHERE cost > ALL(SELECT MIN(cost) FROM building WHERE city = 'can tho');

-- Hiển thị thông tin công trình chưa có kiến trúc sư thiết kế
SELECT * FROM building
WHERE id NOT IN (SELECT building_id FROM design);

-- Hiển thị thông tin các kiến trúc sư cùng năm sinh và cùng nơi tốt nghiệp
SELECT * FROM architect
WHERE (birthday, place) 
IN (
	SELECT birthday, place
    FROM architect  
    GROUP BY birthday, place
    HAVING COUNT(place) > 1 AND COUNT(birthday) > 1
);