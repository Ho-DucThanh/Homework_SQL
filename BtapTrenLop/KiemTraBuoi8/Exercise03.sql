SELECT * FROM products;

SELECT * FROM orders WHERE totalPrice > 500000;

SELECT storeName, addressStore FROM stores;

SELECT * FROM users WHERE email LIKE '%@gmail.com';

SELECT * FROM reviews WHERE rate = 5;

SELECT * FROM products WHERE quantity < 10;

SELECT * FROM products WHERE categoryId = 1;

SELECT Count(userId) FROM users;

SELECT SUM(totalPrice) FROM orders;

SELECT MAX(price) FROM products;

SELECT * FROM stores WHERE statusStore = 1;

SELECT categoryName,  COUNT(categoryName) FROM categories group by categoryName;

SELECT * FROM products p
WHERE NOT EXISTS (
    SELECT * FROM reviews r
    WHERE r.productId = p.productId
);

-- Hiển thị tổng số lượng hàng đã bán (quantityOrder) của từng sản phẩm
SELECT p.productName, SUM(od.quantityOrder) from products P
inner join order_details od
ON od.productId = p.productId
GROUP BY p.productName;

-- Tìm các người dùng (users) chưa đặt bất kỳ đơn hàng nào.
SELECT * FROM users u
WHERE NOT EXISTS (
    SELECT * FROM orders o
    WHERE o.userId = u.userId
);

-- Hiển thị tên cửa hàng và tổng số đơn hàng được thực hiện tại từng cửa hàng
SELECT s.storeName, COUNT(o.orderId) FROM stores s
INNER JOIN orders o
ON o.storeId = s.storeId
GROUP BY s.storeName;

-- Hiển thị thông tin của sản phẩm, kèm số lượng hình ảnh liên quan
SELECT p.productName, COUNT(i.imageId) FROM products p
INNER JOIN images i ON i.productId = p.productId
GROUP BY p.productName;

-- Hiển thị các sản phẩm kèm số lượng đánh giá và đánh giá trung bình.
SELECT p.productName, COUNT(r.reviewId), AVG(r.rate) FROM products p
INNER JOIN reviews r ON r.productId = p.productId
GROUP BY p.productName;

-- Tìm người dùng có số lượng đánh giá nhiều nhất.
SELECT u.userId, COUNT(r.reviewId) FROM users u
INNER JOIN reviews r ON r.userId = u.userId
GROUP BY u.userId
ORDER BY COUNT(r.reviewId) DESC
LIMIT 1;

-- Hiển thị top 3 sản phẩm bán chạy nhất (dựa trên số lượng đã bán).
SELECT p.productName, SUM(od.quantityOrder) FROM products p
INNER JOIN order_details od ON od.productId = p.productId
GROUP BY p.productName
ORDER BY SUM(od.quantityOrder) DESC
LIMIT 3;

-- Tìm sản phẩm bán chạy nhất tại cửa hàng có storeId = 'S001'.
SELECT p.productName, SUM(p.quantity) FROM products p
INNER JOIN stores s ON s.storeId = p.storeId
WHERE s.storeId = 'S001'
GROUP BY p.productName
ORDER BY SUM(p.quantity) DESC
LIMIT 1;

-- Hiển thị danh sách tất cả các sản phẩm có giá trị tồn kho lớn hơn 1 triệu (giá * số lượng).
SELECT p.productName, p.price * p.quantity FROM products p
WHERE p.price * p.quantity > 1000000;

-- Tìm cửa hàng có tổng doanh thu cao nhất
SELECT s.storeName, SUM(o.totalPrice) FROM stores s
INNER JOIN orders o ON o.storeId = s.storeId
GROUP BY s.storeName
ORDER BY SUM(o.totalPrice) DESC
LIMIT 1;

-- Hiển thị danh sách người dùng và tổng số tiền họ đã chi tiêu
SELECT u.userId, u.userName, SUM(o.totalPrice) FROM users u
INNER JOIN orders o ON o.userId = u.userId
GROUP BY u.userId;

-- Tìm đơn hàng có tổng giá trị cao nhất và liệt kê thông tin chi tiết.
SELECT p.productName, od.orderDetailId, SUM(o.totalPrice) FROM orders o
INNER JOIN order_details od ON od.orderId = o.orderId
INNER JOIN products p ON p.productId = od.productId
GROUP BY p.productName, od.orderDetailId
ORDER BY MAX(o.totalPrice) DESC
LIMIT 1;

-- Tính số lượng sản phẩm trung bình được bán ra trong mỗi đơn hàng
SELECT p.productId, AVG(od.quantityOrder) FROM order_details od
INNER JOIN products p ON p.productId = od.productId
GROUP BY p.productId;

-- Hiển thị tên sản phẩm và số lần sản phẩm đó được thêm vào giỏ hàng.
SELECT p.productName, SUM(c.quantityCart) FROM products p
INNER JOIN carts c ON c.productId = p.productId
GROUP BY p.productName;

-- Tìm tất cả các sản phẩm đã bán nhưng không còn tồn kho trong kho hàng
SELECT p.productId, p.productName FROM products p
INNER JOIN order_details od ON od.productId = p.productId
WHERE p.quantity = 0;

-- Tìm các đơn hàng được thực hiện bởi người dùng có email là duong@gmail.com'.
SELECT o.orderId, o.nameOrder FROM orders o
INNER JOIN users u ON u.userId = o.userId
WHERE u.email = 'duong@gmail.com'
GROUP BY o.orderId;

-- Hiển thị danh sách các cửa hàng kèm theo tổng số lượng sản phẩm mà họ sở hữu.
SELECT s.storeName, COUNT(p.productId)  FROM stores s
INNER JOIN products p ON p.storeId = s.storeId
GROUP BY s.storeName;








