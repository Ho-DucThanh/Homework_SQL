CREATE TABLE Products (
	ProductID INT Primary KeY Auto_Increment,
	ProductName VARCHAR(100),
	Quantity INT
);

CREATE TABLE InventoryChanges (
	ChangeID INT Primary Key Auto_Increment,
	ProductID INT,
	OldQuantity INT,
	NewQuantity INT,
	ChangeDate DATETIME,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

DELIMITER $$
CREATE TRIGGER AfterProductUpdate
AFTER UPDATE 
ON Products
FOR EACH ROW
BEGIN
	INSERT INTO InventoryChanges (ProductID, OldQuantity, NewQuantity, ChangeDate)
    VALUES (OLD.ProductID, OLD.Quantity, NEW.Quantity, NOW());
END $$
DELIMITER ;

INSERT INTO Products (ProductName, Quantity)
VALUES 
('Product A', 50),
('Product B', 30),
('Product C', 100);

UPDATE Products
SET Quantity = 60
WHERE ProductID = 1;

UPDATE Products
SET Quantity = 40
WHERE ProductID = 2;

SELECT * FROM Products;
SELECT * FROM InventoryChanges;