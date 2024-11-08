CREATE TABLE `car` (
    CarID INT PRIMARY KEY,
    CarName VARCHAR(100),
    CarType VARCHAR(50),
    DailyRate DECIMAL(10, 2)
);

CREATE TABLE `customer` (
    CustomerID INT PRIMARY KEY,
    Name VARCHAR(100),
    Address VARCHAR(255),
    PhoneNumber VARCHAR(10)
);

CREATE TABLE `rental` (
    RentalID INT PRIMARY KEY,
    CustomerID INT,
    CarID INT,
    StartDate DATETIME,
    EndDate DATETIME,
    TotalAmount DECIMAL(10, 2),
    FOREIGN KEY (CustomerID) REFERENCES customer(CustomerID),
    FOREIGN KEY (CarID) REFERENCES car(CarID)
);


UPDATE `rental`
SET TotalAmount = (    
    SELECT DATEDIFF(Rental.EndDate, Rental.StartDate) * Car.DailyRate     
    FROM Car     
    WHERE Car.CarID = Rental.CarID 
    ) 
WHERE TotalAmount is null;

SELECT * FROM rental;
