CREATE TABLE customers_raw (
    customer_id INT,
    email TEXT,
    phone TEXT,
    country_code TEXT,
    updated_at TIMESTAMP,
    created_at TIMESTAMP
);

CREATE TABLE orders_raw (
    order_id INT,
    customer_id INT,
    product_id TEXT,
    amount DECIMAL(10,2),
    created_at TIMESTAMP,
    currency TEXT
);

CREATE TABLE products_raw (
    product_id TEXT,
    product_name TEXT,
    category TEXT,
    active_flag CHAR(1)
);

CREATE TABLE country_dim (
    country_name TEXT,
    iso_code TEXT
);
