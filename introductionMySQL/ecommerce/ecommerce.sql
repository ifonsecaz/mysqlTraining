#Database Creation
create database ecommerceplatform;

use ecommerceplatform;

/*
Table Definitions:
    Users (user_id, username, email, password, role)
    Products (product_id, product_name, category, price, stock_quantity)
    Orders (order_id, user_id, order_date, total_amount, order_status)
    OrderDetails (order_detail_id, order_id, product_id, quantity, unit_price)
    Payments (payment_id, order_id, payment_date, payment_method, amount)
    Reviews (review_id, product_id, user_id, review_text, rating, review_date)
*/
create table users(
 user_id int primary key,
 username varchar(50),
 email varchar(100) unique,
 password varchar(50),
 role varchar(50)
);

create table products(
	product_id int primary key,
    product_name varchar(50),
    category varchar(50),
    price decimal(7,2),
    stock_quantity int
);

create table orders(
	order_id int primary key,
    user_id int,
    order_date date,
    total_amount int,
    order_status varchar(50),
    foreign  key (user_id) references users (user_id)
);

create table ordedetails(
	order_detail_id int primary key,
    order_id int,
    product_id int,
    quantity int,
    unit_price decimal(9,2),
    foreign key (order_id) references orders (order_id),
    foreign key (product_id) references products (product_id)
);

create table payments(
	payment_id int primary key,
    order_id int,
    payment_date date,
    payment_method varchar(50),
    amount decimal(9,2),
    foreign key (order_id) references orders (order_id)
);

create table reviews(
	review_id int primary key,
    product_id int,
    user_id int,
    review_text varchar (200),
    rating int,
    review_date date,
    foreign key (product_id) references products (product_id),
    foreign key (user_id) references users (user_id)
);

#Data Insertion: Populates the tables

INSERT INTO users (user_id, username, email, password, role) VALUES
(1, 'john_doe', 'john.doe@example.com', 'password123', 'customer'),
(2, 'jane_smith', 'jane.smith@example.com', 'securepass', 'customer'),
(3, 'mike_jones', 'mike.jones@example.com', 'mikepass', 'customer'),
(4, 'sarah_wilson', 'sarah.w@example.com', 'wilson123', 'admin'),
(5, 'alex_green', 'alex.green@example.com', 'greenpass', 'customer'),
(6, 'emily_brown', 'emily.b@example.com', 'brownie22', 'customer'),
(7, 'david_clark', 'david.c@example.com', 'clarkpass', 'customer'),
(8, 'lisa_taylor', 'lisa.t@example.com', 'taylor123', 'admin');

INSERT INTO products (product_id, product_name, category, price, stock_quantity) VALUES
(101, 'Wireless Headphones', 'Electronics', 99.99, 50),
(102, 'Smartphone X', 'Electronics', 799.99, 30),
(103, 'Coffee Maker', 'Home Appliances', 49.95, 25),
(104, 'Running Shoes', 'Sports', 89.99, 40),
(105, 'Bluetooth Speaker', 'Electronics', 59.50, 35),
(106, 'Yoga Mat', 'Sports', 29.99, 60),
(107, 'Desk Lamp', 'Home', 24.99, 45),
(108, 'Backpack', 'Accessories', 39.99, 55),
(109, 'Water Bottle', 'Accessories', 19.99, 70),
(110, 'Smart Watch', 'Electronics', 199.99, 20);

INSERT INTO orders (order_id, user_id, order_date, total_amount, order_status) VALUES
(1001, 1, '2023-10-15', 119.98, 'Completed'),
(1002, 2, '2023-10-16', 799.99, 'Completed'),
(1003, 3, '2023-10-17', 139.97, 'Shipped'),
(1004, 5, '2023-10-18', 89.99, 'Processing'),
(1005, 1, '2023-10-19', 239.97, 'Completed'),
(1006, 6, '2023-10-20', 59.50, 'Shipped'),
(1007, 7, '2023-10-21', 199.99, 'Processing'),
(1008, 2, '2023-10-22', 54.98, 'Completed'),
(1009, 3, '2023-10-23', 49.95, 'Completed'),
(1010, 5, '2023-10-24', 119.00, 'Shipped');

INSERT INTO ordedetails (order_detail_id, order_id, product_id, quantity, unit_price) VALUES
(1, 1001, 101, 1, 99.99),
(2, 1001, 109, 1, 19.99),
(3, 1002, 102, 1, 799.99),
(4, 1003, 104, 1, 89.99),
(5, 1003, 106, 1, 29.99),
(6, 1003, 109, 1, 19.99),
(7, 1004, 104, 1, 89.99),
(8, 1005, 101, 2, 99.99),
(9, 1005, 108, 1, 39.99),
(10, 1006, 105, 1, 59.50),
(11, 1007, 110, 1, 199.99),
(12, 1008, 106, 1, 29.99),
(13, 1008, 107, 1, 24.99),
(14, 1008, 109, 1, 19.99),
(15, 1009, 103, 1, 49.95),
(16, 1010, 105, 2, 59.50);

INSERT INTO payments (payment_id, order_id, payment_date, payment_method, amount) VALUES
(5001, 1001, '2023-10-15', 'Credit Card', 119.98),
(5002, 1002, '2023-10-16', 'PayPal', 799.99),
(5003, 1003, '2023-10-17', 'Credit Card', 139.97),
(5004, 1005, '2023-10-19', 'Debit Card', 239.97),
(5005, 1008, '2023-10-22', 'Credit Card', 54.98),
(5006, 1009, '2023-10-23', 'PayPal', 49.95),
(5007, 1010, '2023-10-24', 'Credit Card', 119.00);

INSERT INTO reviews (review_id, product_id, user_id, review_text, rating, review_date) VALUES
(1, 101, 1, 'Great sound quality and comfortable to wear', 5, '2023-10-16'),
(2, 102, 2, 'Excellent phone with great camera', 5, '2023-10-17'),
(3, 104, 3, 'Very comfortable for running', 4, '2023-10-18'),
(4, 101, 5, 'Battery life could be better', 3, '2023-10-20'),
(5, 105, 6, 'Good sound for the price', 4, '2023-10-21'),
(6, 110, 7, 'Love the fitness tracking features', 5, '2023-10-22'),
(7, 106, 2, 'Perfect for my yoga practice', 5, '2023-10-23'),
(8, 103, 3, 'Makes great coffee quickly', 4, '2023-10-24'),
(9, 108, 1, 'Sturdy and spacious backpack', 5, '2023-10-25'),
(10, 107, 5, 'Nice design but could be brighter', 3, '2023-10-26');

#3
# Retrieves products in the "Electronics" category.
select * from products where category ='Electronics';

# Retrieves user details for a specific user_id, in this case 5.
select * from users where user_id=5;

# Lists orders placed by a specific user
select orders.* from orders
inner join users on users.user_id=orders.user_id
where users.user_id=1;

# Retrieves order details for a specific order ID
select  ordedetails.order_detail_id, products.product_id, products.product_name, products.category, products.price, ordedetails.quantity
from ordedetails 
inner join products on ordedetails.product_id=products.product_id
where  ordedetails.order_id=1008;

# Calculates the average rating for a specific product
select avg(reviews.rating), products.product_name
from products
inner join reviews on reviews.product_id=products.product_id
where reviews.product_id=101;

# Calculates the average rating for all products grouped by product name
select avg(reviews.rating), products.product_name
from products
inner join reviews on reviews.product_id=products.product_id
group by products.product_name;

# Sums up payments made in October 2023
select sum(amount) 
from payments
where month(payment_date) = 10 AND year(payment_date)= 2023;

#5
#Identify the top 5 selling products, based on quantity sold.
select product_id, sum(quantity)
from ordedetails 
group by product_id
order by sum(quantity) desc 
limit 5;

#Identify the top 5 selling products, based on quantity sold, adds details.
select products.product_id, products.product_name, products.category, products.price
from products
inner join ordedetails on ordedetails.product_id=products.product_id
group by ordedetails.product_id
order by sum(ordedetails.quantity) desc 
limit 5;

#Individual orders
# Identifies users who placed orders with a total amount exceeding $100.
select distinct users.username
from users
inner join orders on orders.user_id=users.user_id
where orders.total_amount>=100;

#Total spend
# Calculates the total spending of users and filters those who spent more than $300.
select distinct users.username, sum(orders.total_amount)
from users
inner join orders on orders.user_id=users.user_id
group by orders.user_id
having sum(orders.total_amount)>300;

#Calculate the overall average rating for each product category.
select products.category, avg(reviews.rating)
from products
inner join reviews on reviews.product_id=products.product_id
group by products.category;

#Add product to inventory
INSERT INTO products (product_id, product_name, category, price, stock_quantity)
VALUES (111, 'Wireless Earbuds Pro', 'Electronics', 129.99, 40);

#place order
INSERT INTO orders (order_id, user_id, order_date, total_amount, order_status)
VALUES (1011, 3, CURDATE(), 149.97, 'Processing');

INSERT INTO ordedetails (order_detail_id, order_id, product_id, quantity, unit_price)
VALUES (17, 1011, 104, 1, (SELECT price FROM products WHERE product_id = 104));

INSERT INTO ordedetails (order_detail_id, order_id, product_id, quantity, unit_price)
VALUES (18, 1011, 106, 2, (SELECT price FROM products WHERE product_id = 106));

#Update stock quantity
UPDATE products 
SET stock_quantity = stock_quantity - 1
WHERE product_id = 104;

UPDATE products 
SET stock_quantity = stock_quantity - 2 
WHERE product_id = 104;

#Delete a review
delete from reviews
where review_id =10;

#Update status of order with a stored procedure
CALL UpdateOrderStatus(1006);

select *
from orders
where orders.order_id=1006;

#Generates a report for active users, using a stored procedure
CALL GenerateActiveUsersReport('2023-10-01', '2023-10-31', 5);