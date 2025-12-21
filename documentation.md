## Theory and Database Design Explanation

### Domain description

The database models a simple webshop system. Customers can place orders, each order consists of one or more products, and customers can mark products as favorites. The system stores customer information, product information, orders, order items, and customer favorites.

### Tables and purpose

**Customer**
Stores information about customers such as name, email, phone number, and creation date. Each customer has a unique identifier `customer_id`.

**Product**
Stores products that can be sold in the webshop. Each product has a name, description, price, availability status, and creation date.

**Order**
Represents a purchase made by a customer. Each order belongs to exactly one customer and contains the order date, status, and total amount.

**OrderItem**
Acts as a junction table between Order and Product. It represents which products are included in an order, together with quantity and unit price at the time of purchase.

**CustomerFavorite**
Acts as a junction table between Customer and Product. It stores which products a customer has marked as favorites and when they were marked.

### Data types rationale

- **INT AUTO_INCREMENT** is used for primary keys to keep identifiers compact, fast to index, and easy to join.
- **VARCHAR** is used for names, email, phone, and status because lengths vary but remain bounded; limits (50/255) balance flexibility and storage.
- **TEXT** is used for product descriptions to allow longer free-form content without a strict maximum.
- **DECIMAL(10,2)** is used for monetary values to avoid floating point rounding and to keep currency precise.
- **BOOLEAN** is used for availability since the value is a simple true/false flag.
- **DATE** is used for created/marked/order dates because time-of-day is not needed for this assignment.

### Relationships

- **One-to-many (1-M)**
  One customer can have many orders, but each order belongs to exactly one customer.

- **Many-to-many (M-M)**
  - Customers and products have a many-to-many relationship implemented via the `CustomerFavorite` table.
  - Orders and products have a many-to-many relationship implemented via the `OrderItem` table.

### Keys and constraints

- Each table has a primary key to uniquely identify rows.
- Foreign keys are used to enforce referential integrity between related tables.
- Composite primary keys are used in junction tables to prevent duplicate relationships.
- CHECK constraints ensure that prices, quantities, and totals cannot be negative.

### Data integrity

Data integrity is enforced through several layers:

- **Entity integrity** via primary keys (including the composite key in `CustomerFavorite`) to prevent duplicate rows.
- **Referential integrity** via foreign keys so orders, order items, and favorites always reference existing customers/products.
- **Domain integrity** via data types, NOT NULL constraints, and CHECK constraints (e.g., non-negative prices and totals, positive quantities).
- **Uniqueness** on customer email to prevent duplicate accounts and ensure a stable natural identifier.

### Normalization (Third Normal Form, 3NF)

The database is normalized to Third Normal Form:

1. **First Normal Form (1NF)**
   All tables have atomic values and no repeating groups.

2. **Second Normal Form (2NF)**
   All non-key attributes depend on the whole primary key. In junction tables, attributes depend on the full composite key.

3. **Third Normal Form (3NF)**
   There are no transitive dependencies. Customer data is stored only in the Customer table, product data only in the Product table, and order data only in the Order table.

This design reduces redundancy and improves data integrity.

### Views

Two views are used to simplify common queries:

- `v_available_products` shows only products that are currently available.
- `v_customer_sales` summarizes customer purchases by showing number of orders and total amount spent per customer.

Views improve readability and make complex queries easier to reuse.

### Indexes

Indexes are added to improve performance for common queries:

- Indexes on foreign keys improve JOIN performance.
- Composite indexes are used where filtering and sorting commonly occur together.
- Indexes on junction tables support efficient many-to-many lookups.

Indexes were chosen based on expected query patterns rather than added to every column.
