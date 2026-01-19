CREATE TABLE customers (
		    id INTEGER PRIMARY KEY,
		    first_name VARCHAR(100),
		    last_name VARCHAR(100),
		    email VARCHAR(255),
		    address JSON
		);

CREATE TABLE orders (
		    id INTEGER PRIMARY KEY,
		    customer_id INTEGER,
		    status VARCHAR(50),
		    CONSTRAINT fk_customer
		        FOREIGN KEY (customer_id)
		        REFERENCES customers(id)
		);

CREATE TABLE feedback (
		    id INTEGER PRIMARY KEY,
		    order_id INTEGER,
		    feedback_comment TEXT,
		    rating INTEGER,
		    CONSTRAINT fk_order
		        FOREIGN KEY (order_id)
		        REFERENCES orders(id)
		);
