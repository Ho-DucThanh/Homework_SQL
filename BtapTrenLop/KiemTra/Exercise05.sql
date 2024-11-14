-- Hiển thị tên công trình, tên chủ nhân và tên chủ thầu của công trình đó
SELECT b.name, h.name, c.name
FROM building b
JOIN host h ON b.host_id = h.id
JOIN contractor c ON b.contractor_id = c.id;

-- Hiển thị tên công trình (building), tên kiến trúc sư (architect) và thù lao của kiến trúc sư ở mỗi công trình (design)
SELECT b.name, a.name, d.benefit
FROM building b
JOIN design d ON b.id = d.building_id
JOIN architect a ON d.architect_id = a.id;

-- Hãy cho biết tên và địa chỉ công trình (building) do chủ thầu Công ty xây dựng số 6 thi công (contractor)
SELECT b.name, b.address 
FROM building b
INNER JOIN contractor c 
ON c.id = b.contractor_id
WHERE c.name = 'cty xd so 6';

-- Tìm tên và địa chỉ liên lạc của các chủ thầu (contractor) thi công công trình ở Cần Thơ (building) do kiến trúc sư Lê Kim Dung thiết kế (architect, design)
SELECT c.name, c.address, c.phone
FROM contractor c
INNER JOIN building b ON c.id = b.contractor_id
INNER JOIN design d ON b.id = d.building_id
INNER JOIN architect a ON a.id = d.architect_id
WHERE b.city = 'can tho' AND a.name = 'le kim dung';

-- Hãy cho biết nơi tốt nghiệp của các kiến trúc sư (architect) đã thiết kế (design) công trình Khách Sạn Quốc Tế ở Cần Thơ (building)
SELECT a.place
FROM architect a
INNER JOIN design d ON a.id = d.architect_id
INNER JOIN building b ON d.building_id = b.id
WHERE b.name = 'khach san quoc te' AND b.city = 'can tho';

-- Cho biết họ tên, năm sinh, năm vào nghề của các công nhân có chuyên môn hàn hoặc điện (worker) đã tham gia các công trình (work) mà chủ thầu Lê Văn Sơn (contractor) đã trúng thầu (building)
SELECT w.name, w.birthday, w.year
FROM worker w
INNER JOIN work wo ON w.id = wo.worker_id
INNER JOIN building b ON wo.building_id = b.id
INNER JOIN contractor c ON b.contractor_id = c.id
WHERE w.skill IN ('han', 'dien') AND c.name = 'le van son';

-- Những công nhân nào (worker) đã bắt đầu tham gia công trình Khách sạn Quốc Tế ở Cần Thơ (building) trong giai đoạn từ ngày 15/12/1994 đến 31/12/1994 (work) số ngày tương ứng là bao nhiêu
SELECT w.name, w.birthday, w.`year`, wo.`date`
FROM worker w
INNER JOIN work wo ON w.id = wo.worker_id
INNER JOIN building b ON wo.building_id = b.id
WHERE b.name = 'khach san quoc te' AND b.city = 'can tho' AND wo.date BETWEEN '1994-12-15' AND '1994-12-31';

-- Cho biết họ tên và năm sinh của các kiến trúc sư đã tốt nghiệp ở TP Hồ Chí Minh (architect) và đã thiết kế ít nhất một công trình (design) có kinh phí đầu tư trên 400 triệu đồng (building)
SELECT a.name, a.birthday
FROM architect a
INNER JOIN design d ON a.id = d.architect_id
INNER JOIN building b ON d.building_id = b.id
WHERE a.place = 'tp hcm' AND b.cost > 400000000;

-- Cho biết tên công trình có kinh phí cao nhất
SELECT b.name
FROM building b
WHERE b.cost = (SELECT MAX(cost) FROM building);

-- Cho biết tên các kiến trúc sư (architect) vừa thiết kế các công trình (design) do Phòng dịch vụ sở xây dựng (contractor) thi công vừa thiết kế các công trình do chủ thầu Lê Văn Sơn thi công
SELECT a.name
FROM architect a
INNER JOIN design d ON a.id = d.architect_id
INNER JOIN building b ON d.building_id = b.id
INNER JOIN contractor c ON b.contractor_id = c.id
WHERE c.name = 'phong dich vu so xay dung' AND c.name = 'le van son';

-- Cho biết họ tên các công nhân (worker) có tham gia (work) các công trình ở Cần Thơ (building) nhưng không có tham gia công trình ở Vĩnh Long
SELECT DISTINCT w.name, b.name, w.birthday
FROM worker w
INNER JOIN work wo ON w.id = wo.worker_id
INNER JOIN building b ON wo.building_id = b.id
WHERE b.city = 'can tho' 
AND w.id NOT IN (
    SELECT worker_id 
    FROM work 
    WHERE building_id IN (
        SELECT id 
        FROM building 
        WHERE city = 'vinh long'
    )
);

-- Cho biết tên của các chủ thầu đã thi công các công trình có kinh phí lớn hơn tất cả các công trình do chủ thầu phòng Dịch vụ Sở xây dựng thi công
SELECT DISTINCT c.name
FROM contractor c
INNER JOIN building b ON c.id = b.contractor_id
WHERE b.cost > ALL (
    SELECT cost
    FROM building
    WHERE contractor_id IN (
        SELECT id
        FROM contractor
        WHERE name = 'phong dich vu so xd'
    )
);

-- Cho biết họ tên các kiến trúc sư có thù lao thiết kế một công trình nào đó dưới giá trị trung bình thù lao thiết kế cho một công trình
SELECT a.name
FROM architect a
INNER JOIN design d ON d.architect_id = a.id
WHERE d.benefit < (
	SELECT AVG(benefit) 
    FROM design
);

-- Tìm tên và địa chỉ những chủ thầu đã trúng thầu công trình có kinh phí thấp nhất
SELECT c.name, c.address
FROM contractor c
INNER JOIN building b ON b.contractor_id = c.id
WHERE b.cost = (
		SELECT MIN(cost) FROM building
);

-- Tìm họ tên và chuyên môn của các công nhân (worker) tham gia (work) các công trình do kiến trúc sư Le Thanh Tung thiet ke (architect) (design)
SELECT w.name, w.skill
FROM worker w
INNER JOIN `work` wo ON wo.worker_id = w.id
INNER JOIN building b ON b.id = wo.building_id
INNER JOIN design d ON d.building_id = b.id
INNER JOIN architect a ON a.id = d.architect_id
WHERE a.name = 'Le Thanh Tung';

-- Tìm các cặp tên của chủ thầu có trúng thầu các công trình tại cùng một thành phố
SELECT DISTINCT c1.name AS contractor1, c2.name AS contractor2, b1.city
FROM contractor c1
INNER JOIN building b1 ON c1.id = b1.contractor_id
INNER JOIN building b2 ON b1.city = b2.city AND b1.id != b2.id
INNER JOIN contractor c2 ON b2.contractor_id = c2.id
WHERE c1.id < c2.id;

-- Tìm tổng kinh phí của tất cả các công trình theo từng chủ thầu
SELECT c.name AS contractor_name, SUM(b.cost) AS total_cost
FROM contractor c
JOIN building b ON c.id = b.contractor_id
GROUP BY c.name;    

-- Cho biết họ tên các kiến trúc sư có tổng thù lao thiết kế các công trình lớn hơn 25 triệu
SELECT a.name AS architect_name, SUM(d.benefit) AS total_benefit
FROM architect a
JOIN design d ON a.id = d.architect_id
GROUP BY a.name
HAVING SUM(d.benefit) > 25;

-- Tìm tổng số công nhân đã tham gia ở mỗi công trình
SELECT b.name AS building_name, COUNT(w.worker_id) AS total_worker
FROM building b
JOIN work w ON b.id = w.building_id
GROUP BY b.name;