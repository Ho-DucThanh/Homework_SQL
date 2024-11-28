CREATE TABLE ProductSummary (
	SummaryID INT Primary Key auto_increment,
    TotalQuantity INT
);

INSERT INTO ProductSummary (SummaryID, TotalQuantity)
VALUES (2, 0);

DELIMITER $$
CREATE TRIGGER AfterProductUpdateSummary  
AFTER UPDATE 
ON Products
FOR EACH ROW
BEGIN
	 DECLARE total INT DEFAULT 0;
     SELECT SUM(Quantity) INTO total FROM Products;
     
     UPDATE ProductSummary
     SET TotalQuantity = total
     WHERE SummaryID = 2;
END $$
DELIMITER ;

UPDATE Products
SET Quantity = 70
WHERE ProductID = 2;

SELECT * FROM Products;
SELECT * FROM ProductSummary;