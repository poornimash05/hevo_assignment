----------------------------------------
STEP 1: Copy CSV files into Docker container
----------------------------------------

docker cp /C/Users/Poornima/Downloads/customers.csv postgres-local:/tmp/customers.csv
docker cp /C/Users/Poornima/Downloads/orders.csv postgres-local:/tmp/orders.csv
docker cp /C/Users/Poornima/Downloads/feedback.csv postgres-local:/tmp/feedback.csv

----------------------------------------
STEP 2: Validate files inside container
----------------------------------------

docker exec -it postgres-local bash
ls /tmp

----------------------------------------
STEP 3: Load data using PostgreSQL COPY
----------------------------------------

-- Load customers data
COPY customers(id, first_name, last_name, email, address)
FROM '/tmp/customers.csv'
DELIMITER ','
CSV HEADER;

-- Load orders data
COPY orders(id, customer_id, status)
FROM '/tmp/orders.csv'
DELIMITER ','
CSV HEADER;

-- Load feedback data
COPY feedback(id, order_id, feedback_comment, rating)
FROM '/tmp/feedback.csv'
DELIMITER ','
CSV HEADER;
