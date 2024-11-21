CREATE VIEW expensive_products AS
SELECT productName, price FROM products 
WHERE price > 500000;

-- Truy vấn dữ liệu từ view vừa tạo expensive_products
SELECT * FROM expensive_products;

-- Cập nhật View
SET price = 600000
WHERE productName = 'Product A';

-- XÓA VIEWS
DROP VIEW expensive_products;

-- Tạo view products_categories
CREATE VIEW products_categories AS
SELECT p.productName, c.categoryName FROM products p
INNER JOIN categories c ON c.categoryId = p.categoryId;