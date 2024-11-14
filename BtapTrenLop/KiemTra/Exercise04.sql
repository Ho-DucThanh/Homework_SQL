-- Hiển thị thù lao trung bình của từng kiến trúc sư
SELECT architect_id, AVG(benefit) avg_salary 
FROM design
GROUP BY architect_id;

-- Hiển thị chi phí đầu tư cho các công trình ở mỗi thành phố
SELECT city, SUM(cost) totalcost
FROM building
GROUP BY city; 

-- Tìm các công trình có chi phí trả cho kiến trúc sư lớn hơn 50
SELECT * FROM building
WHERE id IN (SELECT building_id FROM design WHERE benefit > 50);

-- Tìm các thành phố có ít nhất một kiến trúc sư tốt nghiệp
SELECT place
FROM architect
GROUP BY place
HAVING COUNT(place) >= 1;

SELECT *
FROM architect
WHERE place IN (SELECT DISTINCT place FROM architect); 
