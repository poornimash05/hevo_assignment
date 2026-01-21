-- Row counts
SELECT COUNT(*) FROM customers;
SELECT COUNT(*) FROM orders;
SELECT COUNT(*) FROM feedback;

-- Sample records
SELECT * FROM customers LIMIT 10;
SELECT * FROM orders LIMIT 10;

-- Null checks
SELECT COUNT(*) FROM customers WHERE email IS NULL;

