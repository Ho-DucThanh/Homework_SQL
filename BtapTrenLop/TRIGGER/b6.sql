CREATE TABLE ProductRestock (
	RestockID INT PRIMARY KEY AUTO_INCREMENT,
    ProductID INT,
    RestockQuantity INT DEFAULT 0,
    RestockDate DATETIME,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

DELIMITER $$
CREATE TRIGGER AfterProductUpdateRestock 
AFTER UPDATE
ON Products
FOR EACH ROW
BEGIN
	IF NEW.Quantity < 10 AND OLD.Quantity >= 10 THEN
		INSERT INTO ProductRestock (ProductID, RestockQuantity, RestockDate)
        VALUES (NEW.ProductID, 1, NOW());
	END IF;
END $$
DELIMITER ;

UPDATE Products
SET Quantity = 8
WHERE ProductID = 2;

UPDATE Products
SET Quantity = 40
WHERE ProductID = 3;

SELECT * FROM ProductRestock;


