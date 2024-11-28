CREATE TABLE InventoryChangeHistory (
	historyID INT PRIMARY KEY AUTO_INCREMENT,
    ProductID INT,
    oldQuantity INT,
    newQuantity INT,
    changeType ENUM('Increase', 'Decrease'),
    changeDate DATETIME,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

DELIMITER $$
CREATE TRIGGER AfterProductUpdateHistory  
AFTER UPDATE 
ON Products
FOR EACH ROW
BEGIN
	 DECLARE changeType VARCHAR(50);
     
    IF NEW.Quantity > OLD.Quantity THEN
        SET changeType = 'Increase';
        
    ELSEIF NEW.Quantity < OLD.Quantity THEN
        SET changeType = 'Decrease';
    ELSE
        SET changeType = NULL;
    END IF;	
    
    IF NEW.Quantity != OLD.Quantity THEN
		INSERT INTO InventoryChangeHistory (ProductID, oldQuantity, newQuantity, changeType, changeDate)
		VALUES (NEW.ProductID, OLD.Quantity, NEW.Quantity, changeType, NOW()); 
     END IF;
     
END $$
DELIMITER ;

UPDATE Products
SET Quantity = 120
WHERE ProductID = 2;

SELECT * FROM InventoryChangeHistory;