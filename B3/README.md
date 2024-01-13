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

WITH CATEGORY_2 AS (
	SELECT ROUND((sum_product_price) * 100 / (SELECT SUM(sum_product_price) FROM Apple.Categories), 2) AS percentage
	FROM Apple.Categories
	WHERE category_id = 2
)
UPDATE Apple.Categories 
SET category_percentage = (SELECT percentage FROM CATEGORY_2)
WHERE category_id = 2;

WITH CATEGORY_3 AS (
	SELECT ROUND((sum_product_price) * 100 / (SELECT SUM(sum_product_price) FROM Apple.Categories), 2) AS percentage
	FROM Apple.Categories
	WHERE category_id = 3
)
UPDATE Apple.Categories 
SET category_percentage = (SELECT percentage FROM CATEGORY_3)
WHERE category_id = 3;
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