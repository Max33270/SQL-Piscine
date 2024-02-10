USE EXERCICE_FINAL;

SELECT * FROM Customers;

INSERT INTO Customers (customer_name, email, phone_number, address) 
VALUES ('New Customer 1', 'new@email.com', '+1234567890', 'Street 1'),
('New Customer 2', 'new2@email.com', '+1234567890', 'Street 2');

UPDATE Customers SET phone_number = '+9876543210', address = 'Updated Address' WHERE customer_id = 1;

DELETE FROM Customers WHERE customer_id = 2;

ALTER TABLE Customers ADD COLUMN loyalty_points INT DEFAULT 0;
ALTER TABLE Customers DROP COLUMN loyalty_points;

ALTER TABLE Customers DROP CONSTRAINT chk_valid_email;

DROP TABLE CustomerFeedback;
DROP TABLE Customers;

SELECT * FROM Employee;
SELECT * FROM Orders;