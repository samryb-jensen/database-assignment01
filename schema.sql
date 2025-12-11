DROP TABLE IF EXISTS OrderItem;
DROP TABLE IF EXISTS `Order`;
DROP TABLE IF EXISTS CustomerFavorite;
DROP TABLE IF EXISTS Customer;
DROP TABLE IF EXISTS Product;

CREATE TABLE Customer (
    customer_id      INT PRIMARY KEY AUTO_INCREMENT,
    first_name       VARCHAR(50) NOT NULL,
    last_name        VARCHAR(50) NOT NULL,
    email            VARCHAR(255) NOT NULL UNIQUE,
    phone            VARCHAR(50),
    created_at       DATE NOT NULL
);

CREATE TABLE Product (
    product_id       INT PRIMARY KEY AUTO_INCREMENT,
    name             VARCHAR(255) NOT NULL,
    description      TEXT,
    price            DECIMAL(10,2) NOT NULL,
    available        BOOLEAN NOT NULL DEFAULT TRUE,
    created_at       DATE NOT NULL
);

CREATE TABLE `Order` (
    order_id         INT PRIMARY KEY AUTO_INCREMENT,
    customer_id      INT NOT NULL,
    order_date       DATE NOT NULL,
    status           VARCHAR(50) NOT NULL,
    total_amount     DECIMAL(10,2) NOT NULL,
    CONSTRAINT fk_order_customer
        FOREIGN KEY (customer_id) REFERENCES Customer(customer_id)
);

CREATE TABLE OrderItem (
    order_item_id    INT PRIMARY KEY AUTO_INCREMENT,
    order_id         INT NOT NULL,
    product_id       INT NOT NULL,
    quantity         INT NOT NULL,
    unit_price       DECIMAL(10,2) NOT NULL,
    CONSTRAINT fk_orderitem_order
        FOREIGN KEY (order_id) REFERENCES `Order`(order_id),
    CONSTRAINT fk_orderitem_product
        FOREIGN KEY (product_id) REFERENCES Product(product_id)
);

CREATE TABLE CustomerFavorite (
    customer_id      INT NOT NULL,
    product_id       INT NOT NULL,
    marked_at        DATE NOT NULL,
    PRIMARY KEY (customer_id, product_id),
    CONSTRAINT fk_fav_customer
        FOREIGN KEY (customer_id) REFERENCES Customer(customer_id),
    CONSTRAINT fk_fav_product
        FOREIGN KEY (product_id) REFERENCES Product(product_id)
);

DROP TRIGGER IF EXISTS trg_customer_set_created_at;
CREATE TRIGGER trg_customer_set_created_at
BEFORE INSERT ON Customer
FOR EACH ROW
    SET NEW.created_at = CURDATE();

DROP TRIGGER IF EXISTS trg_product_set_created_at;
CREATE TRIGGER trg_product_set_created_at
BEFORE INSERT ON Product
FOR EACH ROW
    SET NEW.created_at = CURDATE();

CREATE OR REPLACE VIEW v_customer_sales AS
SELECT 
    c.customer_id,
    c.first_name,
    c.last_name,
    COUNT(DISTINCT o.order_id) AS order_count,
    SUM(oi.quantity * oi.unit_price) AS total_spent
FROM Customer c
JOIN `Order` o ON o.customer_id = c.customer_id
JOIN OrderItem oi ON oi.order_id = o.order_id
GROUP BY c.customer_id;

CREATE OR REPLACE VIEW v_available_products AS
SELECT 
    product_id,
    name,
    price
FROM Product
WHERE available = TRUE;
