```SQL
CREATE DATABASE IF NOT EXISTS APPLE;
USE APPLE;
```

# 1 - Products

## 1.1 - Table Creation
```SQL
CREATE TABLE IF NOT EXISTS Products
(
	product_id INT AUTO_INCREMENT NOT NULL,
	product_name VARCHAR(255) NOT NULL,
	product_category MEDIUMINT NOT NULL,
	product_price NUMERIC(8,2) NULL,
	product_stock NUMERIC(8) NULL,
	PRIMARY KEY (product_id)
)
ENGINE = INNODB
ENCRYPTION='N';
```
```SQL
ALTER TABLE Apple.Products ADD product_percentage DECIMAL(8,2) NULL;
```
## 1.2 - Table Data
```SQL
INSERT INTO APPLE.Products (product_name, product_category, product_price, product_stock)
	VALUES ('iPhone 13 Pro Max', 1, 958, 10);
INSERT INTO APPLE.Products (product_name, product_category, product_price, product_stock)
	VALUES ('iphone 14 Pro', 1, 1258, 28);
INSERT INTO APPLE.Products (product_name, product_category, product_price, product_stock)
	VALUES ('iphone 15 Mini', 1, 1258, 8);
INSERT INTO APPLE.Products (product_name, product_category, product_price, product_stock)
	VALUES ('Macbook Pro 14', 2, 2229, 2);
INSERT INTO APPLE.Products (product_name, product_category, product_price, product_stock)
	VALUES ('Macbook Pro 16', 2, 2529, 7);
INSERT INTO APPLE.Products (product_name, product_category, product_price, product_stock)
	VALUES ('HomePod Mini', 3, 99, 69);
```    

## 1.3 - Table Display
```SQL
SELECT * FROM Products;
```

# 2 - Categories

## 2.1 - Table Creation
```SQL
CREATE TABLE IF NOT EXISTS Categories
(
	category_id INT AUTO_INCREMENT NOT NULL,
	category_name VARCHAR(255) NOT NULL,
	sum_product_price NUMERIC(8,2) NULL,
	sum_product_stock BIGINT NULL,
	PRIMARY KEY (category_id)
)
ENGINE = INNODB
ENCRYPTION='N';
```
```SQL
ALTER TABLE Apple.Categories ADD category_percentage DECIMAL(8,2) NULL;

WITH CATEGORY_1 AS (
	SELECT ROUND((sum_product_price) * 100 / (SELECT SUM(sum_product_price) FROM Apple.Categories), 2) AS percentage
	FROM Apple.Categories
	WHERE category_id = 1
)
UPDATE Apple.Categories 
SET category_percentage = (SELECT percentage FROM CATEGORY_1)
WHERE category_id = 1;
```

## 2.2 - Table Data
```SQL
INSERT INTO Apple.Categories (category_id, category_name, sum_product_price , sum_product_stock) 
VALUES (
	1, 
    'Cellphone', 
    (SELECT SUM(product_price*product_stock) FROM Apple.Products WHERE product_category = 1), 
    (SELECT SUM(product_stock) FROM Apple.Products WHERE product_category = 1)
);
INSERT INTO Apple.Categories (category_id, category_name, sum_product_price, sum_product_stock)
VALUES (
    2, 
    'PC', 
    (SELECT SUM(product_price*product_stock) FROM Apple.Products WHERE product_category = 2), 
    (SELECT SUM(product_stock) FROM Apple.Products WHERE product_category = 2)
);
INSERT INTO Apple.Categories (category_id, category_name, sum_product_price, sum_product_stock)
VALUES (
    3, 
    'Speaker', 
    (SELECT SUM(product_price*product_stock) FROM Apple.Products WHERE product_category = 3), 
    (SELECT SUM(product_stock) FROM Apple.Products WHERE product_category = 3)
);
```

## 2.3 - Table Display
```SQL
SELECT * FROM Categories;
```
```SQL
SELECT A.*, B.category_name 
FROM Apple.Products A
JOIN Apple.Categories B ON (A.product_category = B.category_id)
```
# 3 - Users

## 3.1 - Table Creation

```SQL
CREATE TABLE IF NOT EXISTS USERS 
(
	user_id INT AUTO_INCREMENT NOT NULL,
	user_lastname VARCHAR(255) NOT NULL,
	user_firstname VARCHAR(255) NOT NULL,
	user_phone VARCHAR(13) NULL,
	user_address VARCHAR(255) NULL,
	user_birthdate DATE NULL,
	PRIMARY KEY (user_id)
)
ENGINE = INNODB
ENCRYPTION='N';
```

## 3.2 - Table Data
```SQL
INSERT INTO Apple.Users (user_lastname, user_firstname, user_phone, user_address, user_birthdate) VALUES
("DOUBST", "Max", "+33666666666", "25 rue du Paradis", 20020923),
("DOUBST", "Toto", "+33777777777", "25 rue de l'Enfer", 20030923);
```

## 3.3 - Table Display
```SQL
SELECT *, TIMESTAMPDIFF(YEAR, user_birthdate, CURDATE()) AS AGE FROM Apple.Users;
```

# 4 - CMD

## 4.1 - Table Creation
```SQL
CREATE TABLE IF NOT EXISTS CMD 
(
	cmd_id INT AUTO_INCREMENT NOT NULL,
	cmd_user_id INT NOT NULL,
	cmd_total_ammount DECIMAL(10,2) NOT NULL,
	cmd_nb_product MEDIUMINT NOT NULL,
	cmd_date DATE NOT NULL,
	cmd_categories VARCHAR(255) NOT NULL,
	cmd_category1_ammount DECIMAL(10,2) NULL,
	cmd_category2_ammount DECIMAL(10,2) NULL,
	cmd_category3_ammount DECIMAL(10,2) NULL,
	PRIMARY KEY (cmd_id),
	FOREIGN KEY (cmd_user_id) REFERENCES Apple.Users(user_id)
)
ENGINE = INNODB
ENCRYPTION='N';
```

```SQL
ALTER TABLE CMD
ADD INDEX cmd_user_id_index (cmd_id, cmd_user_id, cmd_date ASC);
```

## 4.2 - Table Data
```SQL
INSERT INTO Apple.CMD VALUES (1, 1, 2500, 2, CURDATE(), "1", 2516, 0, 0), (2, 2, 3000, 2, CURDATE(), "1", 2516, 0, 0);
```

## 4.3 - Table Display
```SQL
SELECT
    CONCAT(usr.user_firstname, ' ', usr.user_lastname) AS Name,
    CMD.cmd_id, 
    CONCAT(CMD.cmd_total_ammount, '€') AS MONTTANT_CMD, 
    cat1.category_name AS NOM_CAT_1,
    CONCAT(CMD.cmd_category1_ammount, '€') AS CAT_1_MONTANT,
    CONCAT(ROUND(CMD.cmd_category1_ammount * 100 / (SELECT sum_product_price FROM Apple.Categories WHERE category_id = 1), 2),'%') AS CAT_1_PERCENTAGE, 
	CONCAT(CMD.cmd_category2_ammount, '€') AS CAT_2_MONTANT,
    CONCAT(ROUND(CMD.cmd_category2_ammount * 100 / (SELECT sum_product_price FROM Apple.Categories WHERE category_id = 2), 2),'%') AS CAT_2_PERCENTAGE, 
	CONCAT(CMD.cmd_category3_ammount, '€') AS CAT_3_MONTANT,
    CONCAT(ROUND(CMD.cmd_category3_ammount * 100 / (SELECT sum_product_price FROM Apple.Categories WHERE category_id = 3), 2),'%') AS CAT_3_PERCENTAGE
FROM
    Apple.CMD cmd
INNER JOIN Apple.Users usr ON (CMD.cmd_user_id = usr.user_id)
LEFT JOIN Apple.Categories cat1 ON (SUBSTRING(CMD.cmd_categories, 1, 1) = cat1.category_id)
LEFT JOIN Apple.Categories cat2 ON (SUBSTRING(CMD.cmd_categories, 3, 1) = cat2.category_id)
LEFT JOIN Apple.Categories cat3 ON (SUBSTRING(CMD.cmd_categories, 5, 1) = cat3.category_id);
```

# 5 - Tablespaces

```SQL
CREATE TABLESPACE APPLE_TABLESPACE
ADD DATAFILE 'apple.ibd'
AUTOEXTEND_SIZE = 100M
ENCRYPTION = 'N'
ENGINE = INNODB;

ALTER TABLESPACE APPLE_TABLESPACE
AUTOEXTEND_SIZE = 300M; 

ALTER TABLESPACE APPLE_TABLESPACE
RENAME TO exo_tbs;

ALTER TABLE Products
TABLESPACE exo_tbs;

ALTER TABLE Categories
TABLESPACE exo_tbs;

ALTER TABLE CMD
TABLESPACE exo_tbs;

CREATE TABLESPACE APPLE_TABLESPACE_USERS
ADD DATAFILE 'apple_users.ibd'
ENCRYPTION = 'Y';

ALTER TABLE USERS
TABLESPACE APPLE_TABLESPACE_USERS;
```

# 6 - Temporary Tables

```SQL
CREATE TEMPORARY TABLE Products_Category_Over_40
SELECT prd.*, cat.category_name 
FROM Apple.Products prd
JOIN Apple.Categories cat ON prd.product_category = cat.category_id
WHERE prd.product_stock > 40;

SELECT * FROM Products_Category_Over_40; 
```

# 7 - Users and Roles

```SQL
CREATE USER IF NOT EXISTS 'Max'@'localhost' IDENTIFIED BY 'verySafeP@ssword123!' ACCOUNT LOCK; 
CREATE USER IF NOT EXISTS 'Toto'@'localhost' IDENTIFIED BY 'notSoSafeP@ssword123!' ACCOUNT LOCK; 

CREATE USER IF NOT EXISTS 'usr_admin'@'localhost' 
IDENTIFIED WITH caching_sha2_password 
BY 'adminMustChangeThisPasswordFast@123!'
WITH MAX_QUERIES_PER_HOUR 600
PASSWORD EXPIRE INTERVAL 120 DAY
PASSWORD HISTORY 5
ACCOUNT UNLOCK;

ALTER USER 'Max'@'localhost' 
IDENTIFIED BY 'VerySafe3!' 
WITH MAX_QUERIES_PER_HOUR 100
FAILED_LOGIN_ATTEMPTS 3 PASSWORD_LOCK_TIME 2
PASSWORD EXPIRE INTERVAL 60 DAY
PASSWORD HISTORY 10
ACCOUNT UNLOCK; 

ALTER USER 'Toto'@'localhost'
ACCOUNT UNLOCK;

GRANT CREATE, ALTER, DROP ON Apple.Products TO 'Max'@'localhost';
GRANT CREATE, ALTER, DROP ON Apple.Categories TO 'Max'@'localhost';

GRANT CREATE, UPDATE, DROP, CREATE VIEW, CREATE ROUTINE, EXECUTE, TRIGGER ON *.* TO 'usr_admin'@'localhost';

GRANT GRANT OPTION ON *.* TO 'usr_admin'@'localhost';

GRANT SELECT ON Apple.CMD TO 'Max'@'localhost';
GRANT SELECT ON Apple.Users TO 'Max'@'localhost';

GRANT RELOAD ON *.* TO 'usr_admin'@'localhost';

GRANT UPDATE(user_firstname, user_lastname) ON Apple.Users TO 'Max'@'localhost';
GRANT UPDATE(cmd_date) ON Apple.CMD TO 'Max'@'localhost';
```

# 8 - Backups
```shell
mysqldump -u root -p --no-create-info --databases Apple > dump_apple_data.sql
mysqldump -u root -p --no-data --databases Apple > dump_apple_structure.sql
mysqldump -u root -p --xml --databases Apple > dump_apple_structure.xml
mysqldump -u root -p --compact --skip-comments --no-create-info --skip-extended-insert MySQL Apple > dump_mysql_apple.sql
```

# 9 - Views

```SQL
CREATE OR REPLACE VIEW product_view AS 
SELECT prd.* FROM Products prd
INNER JOIN Categories cat on (prd.product_category = cat.category_id) 
WHERE cat.category_percentage = (SELECT MAX(category_percentage) FROM Categories);

CREATE OR REPLACE VIEW category_view AS
SELECT cat.category_name, cat.category_percentage, prd.product_name FROM Products prd
INNER JOIN Categories cat ON (prd.product_category = cat.category_id);
```