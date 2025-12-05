CREATE TABLE IF NOT EXISTS Customer (
    customer_id      INT PRIMARY KEY AUTO_INCREMENT,
    first_name       VARCHAR(50) NOT NULL,
    last_name        VARCHAR(50) NOT NULL,
    email            VARCHAR(255) NOT NULL UNIQUE,
    phone            VARCHAR(50),
    created_at       DATE NOT NULL
);

CREATE TABLE IF NOT EXISTS Product (
    product_id       INT PRIMARY KEY AUTO_INCREMENT,
    name             VARCHAR(255) NOT NULL,
    description      TEXT,
    price            DECIMAL(10,2) NOT NULL,
    created_at       DATE NOT NULL,
    active           BOOLEAN NOT NULL DEFAULT TRUE
);

CREATE TABLE IF NOT EXISTS `Order` (
    order_id         INT PRIMARY KEY AUTO_INCREMENT,
    customer_id      INT NOT NULL,
    order_date       DATE NOT NULL,
    status           VARCHAR(50) NOT NULL,
    total_amount     DECIMAL(10,2) NOT NULL,
    CONSTRAINT fk_order_customer
        FOREIGN KEY (customer_id) REFERENCES Customer(customer_id)
);

CREATE TABLE IF NOT EXISTS OrderItem (
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

CREATE TABLE IF NOT EXISTS CustomerFavorite (
    customer_id      INT NOT NULL,
    product_id       INT NOT NULL,
    marked_at        DATE NOT NULL,
    PRIMARY KEY (customer_id, product_id),
    CONSTRAINT fk_fav_customer
        FOREIGN KEY (customer_id) REFERENCES Customer(customer_id),
    CONSTRAINT fk_fav_product
        FOREIGN KEY (product_id) REFERENCES Product(product_id)
);
