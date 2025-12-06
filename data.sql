INSERT INTO Customer (first_name, last_name, email, phone, created_at) VALUES
    ('Erik', 'Lindberg', 'erik.lindberg@example.com', '+46 70-123 45 67', '2024-01-10'),
    ('Sofia', 'Andersson', 'sofia.andersson@example.com', '+46 70-234 56 78', '2024-02-03'),
    ('Elias', 'Nystrom', 'elias.nystrom@example.com', '+46 70-345 67 89', '2024-02-15'),
    ('Amanda', 'Jansson', 'amanda.jansson@example.com', '+46 70-456 78 90', '2024-03-02'),
    ('Daniel', 'Berglund', 'daniel.berglund@example.com', '+46 70-567 89 01', '2024-03-20');

INSERT INTO Product (name, description, price, created_at, active) VALUES
    ('Organic Cotton T-Shirt', 'Soft crew neck tee in organic cotton', 199.00, '2024-01-05', TRUE),
    ('Slim Fit Jeans', 'Dark wash stretch denim, mid-rise', 699.00, '2024-01-18', TRUE),
    ('Wool Beanie', 'Rib-knit merino beanie', 249.00, '2024-02-01', TRUE),
    ('Denim Jacket', 'Classic trucker jacket with metal buttons', 899.00, '2024-02-10', TRUE),
    ('Waterproof Rain Jacket', 'Lightweight hooded rain jacket with taped seams', 1499.00, '2024-02-22', TRUE),
    ('Linen Shorts', 'Relaxed fit linen shorts, drawstring waist', 449.00, '2024-03-01', FALSE);

INSERT INTO `Order` (customer_id, order_date, status, total_amount) VALUES
    (1, '2024-03-05', 'Processing', 647.00),
    (2, '2024-03-07', 'Shipped', 1598.00),
    (3, '2024-03-12', 'Delivered', 1997.00),
    (1, '2024-03-18', 'Delivered', 1146.00),
    (4, '2024-03-22', 'Cancelled', 1598.00);

INSERT INTO OrderItem (order_id, product_id, quantity, unit_price) VALUES
    (1, 1, 2, 199.00),
    (1, 3, 1, 249.00),
    (2, 2, 1, 699.00),
    (2, 4, 1, 899.00),
    (3, 5, 1, 1499.00),
    (3, 3, 2, 249.00),
    (4, 1, 1, 199.00),
    (4, 6, 1, 449.00),
    (4, 3, 2, 249.00),
    (5, 4, 1, 899.00),
    (5, 2, 1, 699.00);

INSERT INTO CustomerFavorite (customer_id, product_id, marked_at) VALUES
    (1, 1, '2024-03-10'),
    (1, 5, '2024-03-11'),
    (2, 3, '2024-03-08'),
    (3, 2, '2024-03-13'),
    (3, 5, '2024-03-14'),
    (4, 4, '2024-03-20'),
    (5, 1, '2024-03-22');
