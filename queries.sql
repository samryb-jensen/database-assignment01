/* 1) INSERT: Create a new customer */
INSERT INTO Customer (first_name, last_name, email, phone)
VALUES ('Linnea', 'Karlsson', 'linnea.karlsson@example.com', '+46 70-678 90 12');

/* 2) UPDATE: Change product availability and price */
UPDATE Product
SET available = TRUE,
    price = 429.00
WHERE product_id = 6;

/* 3) SELECT with LIMIT and OFFSET: Available products sorted by name (page 1) */
SELECT product_id, name, price
FROM Product
WHERE available = TRUE
ORDER BY name
LIMIT 3 OFFSET 0;

/* 4) SELECT with LIMIT and OFFSET: Available products sorted by name (page 2) */
SELECT product_id, name, price
FROM Product
WHERE available = TRUE
ORDER BY name
LIMIT 3 OFFSET 3;

/* 5) SQL functions (COUNT, SUM): Orders per day and total revenue per day */
SELECT
  o.order_date,
  COUNT(*) AS orders_count,
  SUM(o.total_amount) AS revenue
FROM `Order` o
GROUP BY o.order_date
ORDER BY o.order_date;

/* 6) Free-text search using LIKE: Find products matching a keyword in name or description */
SELECT product_id, name, price, available
FROM Product
WHERE name LIKE '%jacket%'
ORDER BY name;

/* 7) JOIN with at least three tables: Show order details (customer + order + items + product) */
SELECT
  o.order_id,
  o.order_date,
  o.status,
  c.customer_id,
  c.first_name,
  c.last_name,
  p.product_id,
  p.name,
  oi.quantity,
  oi.unit_price,
  (oi.quantity * oi.unit_price) AS total
FROM `Order` o
JOIN Customer c ON c.customer_id = o.customer_id
JOIN OrderItem oi ON oi.order_id = o.order_id
JOIN Product p ON p.product_id = oi.product_id
ORDER BY o.order_id, p.name;

/* 8) Use a VIEW: List only available products via v_available_products */
SELECT *
FROM v_available_products
ORDER BY price;

/* 9) Use a VIEW: Show customer sales summary via v_customer_sales */
SELECT *
FROM v_customer_sales
ORDER BY total_spent DESC;

/* 10) DELETE: Remove one specific favorite entry (safe, targeted delete) */
DELETE FROM CustomerFavorite
WHERE customer_id = 5 AND product_id = 1;
