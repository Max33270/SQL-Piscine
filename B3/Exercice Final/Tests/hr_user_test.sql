USE EXERCICE_FINAL;

SELECT * FROM Employee;

INSERT INTO Employee (employee_name, job_title, department, hire_date, salary)
VALUES ('John Doe', 'Software Engineer', 'IT', '2024-01-15', 50000.00), 
('John Deer', 'Software Engineer', 'IT', '2024-01-15', 50000.00);

UPDATE Employee SET salary = 90000.00 WHERE employee_id = 1;

DELETE FROM Employee WHERE employee_id = 2;

ALTER TABLE Employee ADD COLUMN bonus DECIMAL(8, 2) DEFAULT 0;

UPDATE Employee SET bonus = 2000.00 WHERE employee_id = 1;

ALTER TABLE Employee DROP COLUMN bonus;

DROP TABLE Employee;
SELECT * FROM Orders;
SELECT * FROM Customers;
SELECT * FROM Shipments;

INSERT INTO Employee (employee_name, job_title, department, hire_date, salary)
VALUES ('Alexandre Doe', 'DevOps', 'IT', '2024-01-15', 1500.00);