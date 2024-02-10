USE EXERCICE_FINAL;

SELECT * FROM ORDERS; 
SELECT * FROM Shipments;

INSERT INTO Orders (quantity_ordered, order_date, delivery_address)
VALUES (10, '2024-01-15', '123 Street'), (3, '2024-01-15', '456 Street');

INSERT INTO Shipments (order_id, shipment_date, delivery_status, shipping_company, tracking_number, estimated_delivery_date)
VALUES (1, '2024-01-15', 'Shipped', 'FastShip', 'TRACK123', '2024-01-30'), 
(2, '2024-01-15', 'Processing', 'FastShip', 'TRACK124', '2024-02-10');

UPDATE Shipments SET delivery_status = 'Delivered', estimated_delivery_date = '2024-01-27' WHERE shipment_id = 1;

DELETE FROM Shipments WHERE shipment_id = 2;

ALTER TABLE Shipments DROP INDEX unique_tracking_number;

ALTER TABLE Shipments DROP FOREIGN KEY fk_shipments_orders;

DROP TABLE Shipments;

SELECT * FROM Employee;
SELECT * FROM Customers;