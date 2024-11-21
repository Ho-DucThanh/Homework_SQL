CREATE INDEX idx_productName 
ON products (productName)

-- Hiển thị danh sách các index trong cơ sở dữ liệu?
SHOW INDEXES FROM products;

-- Trình bày cách xóa index idx_productName đã tạo trước đó?
DROP INDEX idx_productName
ON products;

-- Tạo một procedure tên getProductByPrice để lấy danh sách sản phẩm với giá lớn hơn một giá trị đầu vào (priceInput)?
DELIMITER $$
CREATE PROCEDURE getProductByPrice (IN priceInput INT) 
BEGIN
	SELECT * FROM products
    WHERE price > priceInput;
END $$
DELIMITER ;

-- gọi procedure getProductByPrice với đầu vào là 500000?
CALL getProductByPrice(500000);

-- Tạo một procedure getOrderDetails trả về thông tin chi tiết đơn hàng với đầu vào là orderId?
DELIMITER $$
CREATE PROCEDURE getOrderDetails  (IN orderId_orderDetails VARCHAR(255)) 
BEGIN
	SELECT * FROM order_details
    WHERE orderId = orderId_orderDetails;
END $$
DELIMITER ;

CALL getOrderDetails("c0c5c360-63c7-4695-99ba-0c013e135691")

-- xóa procedure getOrderDetails?
DROP PROCEDURE getOrderDetails;

-- Tạo một procedure tên addNewProduct để thêm mới một sản phẩm vào bảng products. Các tham số gồm productName, price, description, và quantity.
DELIMITER $$
CREATE PROCEDURE addNewProduct (IN productNameInput VARCHAR(255), IN priceInput INT, IN descriptionInput VARCHAR(255), IN quantityInput INT)
BEGIN
    INSERT INTO products (productName, price, description, quantity)
    VALUES (productNameInput, priceInput, descriptionInput, quantityInput);
END $$
DELIMITER ;

CALL addNewProduct("Product A", 500000, "Description A", 10);

-- Tạo một procedure tên deleteProductById để xóa sản phẩm khỏi bảng products dựa trên tham số productId.
DELIMITER $$
CREATE PROCEDURE deleteProductById (IN productIdInput VARCHAR(255)) 
BEGIN
    DELETE FROM products
    WHERE productId = productIdInput;
END $$
DELIMITER ;

-- Tạo một procedure tên searchProductByName để tìm kiếm sản phẩm theo tên (tìm kiếm gần đúng) từ bảng products.
DELIMITER $$
CREATE PROCEDURE searchProductByName (IN productNameInput VARCHAR(255))
BEGIN
    SELECT * FROM products
    WHERE productName LIKE CONCAT('%', productNameInput, '%');
END $$
DELIMITER ;

CALL searchProductByName("Loa");

-- Tạo một procedure tên filterProductsByPriceRange để lấy danh sách sản phẩm có giá trong khoảng từ minPrice đến maxPrice.
DELIMITER $$
CREATE PROCEDURE filterProductsByPriceRange (IN minPriceInput INT, IN maxPriceInput INT)
BEGIN
    SELECT * FROM products
    WHERE price BETWEEN minPriceInput AND maxPriceInput;
END $$
DELIMITER ;

-- Tạo một procedure tên paginateProducts để phân trang danh sách sản phẩm, với hai tham số pageNumber và pageSize.
DELIMITER $$
CREATE PROCEDURE paginateProducts (IN pageNumberInput INT, IN pageSizeInput INT)
BEGIN
	DECLARE offset_value INT;
    SET offset_value = (pageNumberInput - 1) * pageSizeInput;
    SELECT * FROM products
    LIMIT pageSizeInput
    OFFSET offset_value;
END $$
DELIMITER ;

CALL paginateProducts(2, 5);





