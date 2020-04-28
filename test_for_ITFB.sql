# Создание базы данных

DROP DATABASE if EXISTS shop;
CREATE DATABASE shop;
USE shop;

DROP TABLE if EXISTS products;
CREATE TABLE products (
	product_id INT AUTO_INCREMENT PRIMARY KEY,
	product_name VARCHAR(100),
	brand VARCHAR (100),
	price INT
);

DROP TABLE if EXISTS orders;
CREATE TABLE orders (
	orders_id INT AUTO_INCREMENT PRIMARY KEY,
	product_id INT,
	users_id INT,
	quantum INT,
	o_date DATETIME
);

DROP TABLE if EXISTS users;
CREATE TABLE users (
	users_id INT AUTO_INCREMENT PRIMARY KEY,
	name varchar (100),
	birthday DATE
);

DROP TABLE if EXISTS providers;
CREATE TABLE providers (
	provider_id INT AUTO_INCREMENT PRIMARY KEY,
	provider_name varchar (100),
	product_id INT
);

# Создание связей

ALTER TABLE shop.orders ADD CONSTRAINT orders_FK FOREIGN KEY (product_id) REFERENCES shop.products(product_id);
ALTER TABLE shop.providers ADD CONSTRAINT providers_FK FOREIGN KEY (product_id) REFERENCES shop.products(product_id);
ALTER TABLE shop.orders ADD CONSTRAINT orders_FK_1 FOREIGN KEY (users_id) REFERENCES shop.users(users_id);

# Заполняем

INSERT INTO products (product_name, brand, price) VALUES 
	('гречка', 'Гудвил', '100'),
	('гречка', 'Ядрышко', '55'),
	('гречка', 'Польза', '90'),
	('макароны', 'Макфа', '80'),
	('рис', 'Польза', '110')
;

# Выбрать все марки гречки

SELECT brand FROM products WHERE product_name = 'гречка';

# Выбрать все транзакции с суммой менее 1 рубля

SELECT orders_id FROM orders WHERE quantum < '1';

# Выбрать все транзакции постоянного покупателя Иванова

SELECT orders_id FROM orders WHERE users_id IN
(SELECT users_id FROM users WHERE name = 'Иванов');

# Выбрать топ-5 покупателей, которые совершили больше всего покупок

SELECT TOP 5 users_id, quantum FROM orders ORDER BY quantum;

# Сформировать выгрузку (отчет), в котором будет указано, сколько в среднем в месяц тратит Иванов в магазине

SELECT AVG(quantum) FROM orders WHERE users_id IN
	(SELECT users_id FROM users WHERE name = 'Иванов') ORDER BY MONTH (orders.o_date);



