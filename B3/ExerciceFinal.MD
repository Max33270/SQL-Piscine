```SQL
CREATE DATABASE IF NOT EXISTS EXERCICE_FINAL;
USE EXERCICE_FINAL; 

-- TABLE CREATION -- 
CREATE TABLE IF NOT EXISTS Orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    quantity_ordered INT NOT NULL,
    order_date DATE NOT NULL,
    delivery_address VARCHAR(255) NOT NULL
)
ENGINE = INNODB
ENCRYPTION='N';

CREATE TABLE IF NOT EXISTS Shipments (
    shipment_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    shipment_date DATE NOT NULL,
    delivery_status VARCHAR(50) NOT NULL,
    shipping_company VARCHAR(100) NOT NULL,
    tracking_number VARCHAR(50) NOT NULL,
    estimated_delivery_date DATE,
    CONSTRAINT unique_tracking_number UNIQUE (tracking_number),
    CONSTRAINT fk_shipments_orders FOREIGN KEY (order_id) REFERENCES Orders(order_id)
)
ENGINE = INNODB
ENCRYPTION='N';

CREATE TABLE IF NOT EXISTS Customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_name VARCHAR(255) NOT NULL,
    email VARCHAR(100) NOT NULL,
    phone_number VARCHAR(15),
    address VARCHAR(255), 
    CONSTRAINT chk_valid_email CHECK (email LIKE '%@%' AND email LIKE '%.%')
)
ENGINE = INNODB
ENCRYPTION='Y';

CREATE TABLE IF NOT EXISTS CustomerFeedback (
    feedback_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT NOT NULL,
    feedback_date DATE NOT NULL,
    rating INT NOT NULL,
    comments TEXT,
    CONSTRAINT fk_customerfeedback_customers FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
)
ENGINE = INNODB
ENCRYPTION='N';

CREATE TABLE IF NOT EXISTS Employee (
    employee_id INT AUTO_INCREMENT PRIMARY KEY,
    employee_name VARCHAR(255) NOT NULL,
    job_title VARCHAR(100) NOT NULL,
    department VARCHAR(100),
    hire_date DATE NOT NULL,
    salary DECIMAL(10, 2) NOT NULL, 
    CONSTRAINT minimum_salary_france2024 CHECK (salary >= 1766.92)
)
ENGINE = INNODB
ENCRYPTION='Y';

-- ROLE CREATION -- 
CREATE ROLE IF NOT EXISTS logistics; 
CREATE ROLE IF NOT EXISTS logistics_admin; 

CREATE ROLE IF NOT EXISTS commerce_G; 
CREATE ROLE IF NOT EXISTS commerce; 
CREATE ROLE IF NOT EXISTS commerce_admin; 

CREATE ROLE IF NOT EXISTS human_ressources;

-- USER CREATION -- 
CREATE USER IF NOT EXISTS 'usr_logistics_1'@'localhost' IDENTIFIED BY 'verySafeP@ssword123!' ACCOUNT LOCK;
CREATE USER IF NOT EXISTS 'usr_logistics_admin'@'localhost' IDENTIFIED BY 'verySafeP@ssword123!' ACCOUNT LOCK; 

CREATE USER IF NOT EXISTS 'usr_commerce_1'@'localhost' IDENTIFIED BY 'verySafeP@ssword123!' ACCOUNT LOCK; 
CREATE USER IF NOT EXISTS 'usr_commerce_admin'@'localhost' IDENTIFIED BY 'verySafeP@ssword123!' ACCOUNT LOCK; 
CREATE USER IF NOT EXISTS 'usr_commerce_management'@'localhost' IDENTIFIED BY 'verySafeP@ssword123!' ACCOUNT LOCK; 

CREATE USER IF NOT EXISTS 'usr_human_ressources'@'localhost' IDENTIFIED BY 'verySafeP@ssword123!' ACCOUNT LOCK; 

CREATE USER IF NOT EXISTS 'usr_ADMIN_EX_FINAL'@'localhost' IDENTIFIED BY 'adminSafeP@ssword123!'; 

-- USER PASSWORD MANAGEMENT --
ALTER USER 'usr_logistics_1'@'localhost'
WITH MAX_QUERIES_PER_HOUR 100
FAILED_LOGIN_ATTEMPTS 3 PASSWORD_LOCK_TIME 2
PASSWORD EXPIRE INTERVAL 60 DAY
PASSWORD HISTORY 10
ACCOUNT UNLOCK; 

ALTER USER 'usr_logistics_admin'@'localhost'
WITH MAX_QUERIES_PER_HOUR 500
FAILED_LOGIN_ATTEMPTS 3 PASSWORD_LOCK_TIME 2
PASSWORD EXPIRE INTERVAL 120 DAY
PASSWORD HISTORY 10
ACCOUNT UNLOCK; 

ALTER USER 'usr_commerce_1'@'localhost'
WITH MAX_QUERIES_PER_HOUR 100
FAILED_LOGIN_ATTEMPTS 3 PASSWORD_LOCK_TIME 2
PASSWORD EXPIRE INTERVAL 60 DAY
PASSWORD HISTORY 10
ACCOUNT UNLOCK; 

ALTER USER 'usr_commerce_admin'@'localhost'
WITH MAX_QUERIES_PER_HOUR 500
FAILED_LOGIN_ATTEMPTS 3 PASSWORD_LOCK_TIME 2
PASSWORD EXPIRE INTERVAL 120 DAY
PASSWORD HISTORY 10
ACCOUNT UNLOCK; 

ALTER USER 'usr_commerce_management'@'localhost'
WITH MAX_QUERIES_PER_HOUR 600
FAILED_LOGIN_ATTEMPTS 3 PASSWORD_LOCK_TIME 2
PASSWORD EXPIRE INTERVAL 120 DAY
PASSWORD HISTORY 10
ACCOUNT UNLOCK; 

ALTER USER 'usr_human_ressources'@'localhost'
WITH MAX_QUERIES_PER_HOUR 600
FAILED_LOGIN_ATTEMPTS 3 PASSWORD_LOCK_TIME 2
PASSWORD EXPIRE INTERVAL 60 DAY
PASSWORD HISTORY 10
ACCOUNT UNLOCK; 

-- ROLE OPTIONS -- 
GRANT SELECT, UPDATE, DELETE, INSERT ON EXERCICE_FINAL.Orders TO 'logistics';
GRANT SELECT, UPDATE, DELETE, INSERT ON EXERCICE_FINAL.Shipments TO 'logistics';
GRANT CREATE, ALTER, DROP ON EXERCICE_FINAL.Orders TO 'logistics_admin';
GRANT CREATE, ALTER, DROP ON EXERCICE_FINAL.Shipments TO 'logistics_admin';

GRANT SELECT, UPDATE, DELETE, INSERT ON EXERCICE_FINAL.Customers TO 'commerce';
GRANT SELECT, UPDATE, DELETE, INSERT ON EXERCICE_FINAL.CustomerFeedback TO 'commerce';
GRANT CREATE, ALTER, DROP ON EXERCICE_FINAL.Customers TO 'commerce_admin';
GRANT CREATE, ALTER, DROP ON EXERCICE_FINAL.CustomerFeedback TO 'commerce_admin';
GRANT 'commerce' TO 'commerce_G';
GRANT 'commerce_admin' TO 'commerce_G';

GRANT SELECT, UPDATE, DELETE, INSERT, CREATE, ALTER ON EXERCICE_FINAL.Employee TO 'human_ressources';

GRANT ALL PRIVILEGES ON ROLES_AND_PRIVILEGES.* TO 'usr_ADMIN_EX_FINAL'@'localhost';

GRANT 'logistics' TO 'usr_logistics_1'@'localhost';
GRANT 'logistics_admin' TO 'usr_logistics_admin'@'localhost';

GRANT 'commerce' TO 'usr_commerce_1'@'localhost';
GRANT 'commerce_admin' TO 'usr_commerce_admin'@'localhost';
GRANT 'commerce_G' TO 'usr_commerce_management'@'localhost';

GRANT 'human_ressources' TO 'usr_human_ressources'@'localhost';

GRANT 'commerce_G', 'logistics', 'logistics_admin', 'human_ressources' TO 'usr_ADMIN_EX_FINAL'@'localhost';

SET DEFAULT ROLE 'logistics'@'%' TO 'usr_logistics_1'@'localhost';
SET DEFAULT ROLE 'logistics_admin'@'%' TO 'usr_logistics_admin'@'localhost';

SET DEFAULT ROLE 'commerce'@'%' TO 'usr_commerce_1'@'localhost';
SET DEFAULT ROLE 'commerce_admin'@'%' TO 'usr_commerce_admin'@'localhost';
SET DEFAULT ROLE 'commerce_G'@'%' TO 'usr_commerce_management'@'localhost';

SET DEFAULT ROLE 'human_ressources'@'%' TO 'usr_human_ressources'@'localhost';

FLUSH PRIVILEGES;
SHOW GRANTS FOR 'human_ressources'@'%';

-- TABLESPACE -- 
CREATE TABLESPACE ORDERS_TABLESPACE
ADD DATAFILE 'orders_tablespace.ibd'
AUTOEXTEND_SIZE = 500M
ENCRYPTION = 'N';
ALTER TABLE Orders
TABLESPACE ORDERS_TABLESPACE;

CREATE TABLESPACE SHIPMENTS_TABLESPACE
ADD DATAFILE 'shipments_tablespace.ibd'
AUTOEXTEND_SIZE = 500M
ENCRYPTION = 'N';
ALTER TABLE Shipments
TABLESPACE SHIPMENTS_TABLESPACE;

CREATE TABLESPACE CUSTOMERS_TABLESPACE
ADD DATAFILE 'customers_tablespace.ibd'
AUTOEXTEND_SIZE = 500M
ENCRYPTION = 'Y';
ALTER TABLE Customers
TABLESPACE CUSTOMERS_TABLESPACE;

CREATE TABLESPACE CUSTOMERFEEDBACK_TABLESPACE
ADD DATAFILE 'customer_feedback_tablespace.ibd'
AUTOEXTEND_SIZE = 500M
ENCRYPTION = 'N';
ALTER TABLE CustomerFeedback
TABLESPACE CUSTOMERFEEDBACK_TABLESPACE;

CREATE TABLESPACE EMPLOYEE_TABLESPACE
ADD DATAFILE 'employee_tablespace.ibd'
AUTOEXTEND_SIZE = 500M
ENCRYPTION = 'Y';
ALTER TABLE Employee
TABLESPACE EMPLOYEE_TABLESPACE;

-- BACKUP -- 
# mysqldump -u root -p --databases EXERCICE_FINAL > dump_mysql_exercice_final.sql

-- TESTS -- 
####### Connected as USER usr_commerce_management -> ROLE Functional
-- WORKS -- 
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

-- DOESN'T WORK (COMMAND DENIED TO USER) -- 
SELECT * FROM Employee;
SELECT * FROM Orders;

####### CONNECTED AS USER usr_commerce_1 -> ROLE Functional
-- WORKS -- 
USE EXERCICE_FINAL;

SELECT * FROM Customers;

INSERT INTO Customers (customer_name, email, phone_number, address) 
VALUES ('New Customer 3', 'new3@email.com', '+1234567890', 'Street 3');

UPDATE Customers SET phone_number = '+9876543210', address = 'Updated Address 3' WHERE customer_id = 3;

DELETE FROM Customers WHERE customer_id = 3;

-- DOESN'T WORK (COMMAND DENIED TO USER) -- 
ALTER TABLE Customers ADD COLUMN loyalty_points INT DEFAULT 0;
ALTER TABLE Customers DROP COLUMN loyalty_points;
ALTER TABLE Customers DROP CONSTRAINT chk_valid_email;

DROP TABLE CustomerFeedback;
DROP TABLE Customers;

####### CONNECTED AS USER usr_logistics_1 -> ROLE Functional
-- WORKS -- 
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
-- DOESN'T WORK (COMMAND DENIED TO USER) -- 
ALTER TABLE Shipments DROP INDEX unique_tracking_number;

ALTER TABLE Shipments DROP FOREIGN KEY fk_shipments_orders;

DROP TABLE Shipments;

SELECT * FROM Employee;
SELECT * FROM Customers;


####### CONNECTED AS USER usr_human_ressources -> ROLE Functional
-- WORKS -- 
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
-- DOESN'T WORK (COMMAND DENIED TO USER) -- 
DROP TABLE Employee;
SELECT * FROM Orders;
SELECT * FROM Customers;
SELECT * FROM Shipments;

INSERT INTO Employee (employee_name, job_title, department, hire_date, salary)
VALUES ('Alexandre Doe', 'DevOps', 'IT', '2024-01-15', 1500.00);

-- QUESTION OUVERTE -- 
# Vous venez de prendre connaissance d'une intrusion sur le serveur BDD. Quelles sont vos premières actions en tant que DBA? 
# Réponse : Arrêter le service MySQL, vérifier les logs dans tmp/mysql.log, supprimer les utilisateurs malveillants et renforcer la sécurité 
# pour l'accès des utilisateurs aux différentes tables (donner les privilèges uniquement aux tables que l'utilisateur a besoin).

```