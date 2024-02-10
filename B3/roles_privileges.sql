CREATE DATABASE IF NOT EXISTS ROLES_AND_PRIVILEGES;
USE ROLES_AND_PRIVILEGES;

CREATE TABLE IF NOT EXISTS Clients
(
	client_id INT AUTO_INCREMENT NOT NULL,
	client_lastname VARCHAR(255) NOT NULL,
    client_firstname VARCHAR(255) NOT NULL,
	client_phone VARCHAR(13) NULL,
    client_address VARCHAR(255) NULL,
    client_birthdate DATE NULL,
	PRIMARY KEY (client_id)
)
ENGINE = INNODB
ENCRYPTION='N';

CREATE TABLE IF NOT EXISTS Compta
(
    transaction_id INT AUTO_INCREMENT NOT NULL,
    date_of_transaction DATE NOT NULL,
    description VARCHAR(255) NOT NULL, 
    amount DECIMAL(10,2) NULL,
	PRIMARY KEY (transaction_id)
)
ENGINE = INNODB
ENCRYPTION='N';

CREATE ROLE client_G; 
CREATE ROLE compta_G; 

CREATE ROLE client; 
CREATE ROLE client_A; 

CREATE ROLE compta; 
CREATE ROLE compta_A; 

CREATE USER IF NOT EXISTS 'usr_client_1'@'localhost' IDENTIFIED BY 'verySafeP@ssword123!';
CREATE USER IF NOT EXISTS 'usr_client_admin'@'localhost' IDENTIFIED BY 'verySafeP@ssword123!';

CREATE USER IF NOT EXISTS 'usr_compta_1'@'localhost'  IDENTIFIED BY 'verySafeP@ssword123!';
CREATE USER IF NOT EXISTS 'usr_compta_admin'@'localhost' IDENTIFIED BY 'verySafeP@ssword123!';

CREATE USER IF NOT EXISTS 'ADMINBDD_DBA'@'localhost' IDENTIFIED BY 'adminSafeP@ssword123!';

GRANT SELECT, UPDATE, DELETE, INSERT ON ROLES_AND_PRIVILEGES.Clients TO 'client';
GRANT CREATE, ALTER, DROP ON ROLES_AND_PRIVILEGES.Clients TO 'client_A';

GRANT SELECT, UPDATE, DELETE, INSERT ON ROLES_AND_PRIVILEGES.Compta TO 'compta';
GRANT CREATE, ALTER, DROP ON ROLES_AND_PRIVILEGES.Compta TO 'compta_A';

GRANT ALL PRIVILEGES ON ROLES_AND_PRIVILEGES.* TO 'ADMINBDD_DBA'@'localhost';

GRANT 'client' TO 'usr_client_1'@'localhost';
GRANT 'compta' TO 'usr_compta_1'@'localhost';

GRANT 'client_A' TO 'usr_client_admin'@'localhost';
GRANT 'compta_A' TO 'usr_compta_admin'@'localhost';

GRANT 'compta_A', 'compta_A' to 'ADMINBDD_DBA'@'localhost';

SET DEFAULT ROLE 'client'@'%' TO 'usr_client_1'@'localhost';
SET DEFAULT ROLE 'client_A'@'%' TO 'usr_client_admin'@'localhost';

SET DEFAULT ROLE 'compta'@'%' TO 'usr_compta_1'@'localhost';
SET DEFAULT ROLE 'compta_A'@'%' TO 'usr_compta_admin'@'localhost';