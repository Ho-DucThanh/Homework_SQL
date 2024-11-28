DELIMITER $$
CREATE TRIGGER AfterProductUpdateSetDate 
BEFORE UPDATE 
ON Products
FOR EACH ROW
BEGIN
	 SET NEW.LastUpdated = NOW();
END $$
DELIMITER ;

ALTER TABLE Products
ADD LastUpdated DATETIME;

UPDATE Products 
SET LastUpdated = NOW()
WHERE ProductID = 4;

SELECT * FROM Products;