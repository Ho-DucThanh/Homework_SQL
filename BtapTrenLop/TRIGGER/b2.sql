DELIMITER $$
CREATE TRIGGER BeforeProductDelete 
BEFORE DELETE
ON Products
FOR EACH ROW
BEGIN
	IF OLD.Quantity > 10 THEN
		SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'KHONG THE XOA SAN PHAM CO QUANTITY > 10';
    END IF;
END $$
DELIMITER ;

UPDATE Products
SET Quantity = 3
WHERE ProductID = 1;

DELETE FROM InventoryChanges WHERE ProductID = 1;
DELETE FROM Products WHERE ProductID = 1;


SELECT * FROM Products;