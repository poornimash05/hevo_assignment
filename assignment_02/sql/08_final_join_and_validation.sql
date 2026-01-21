CREATE OR REPLACE VIEW PC_HEVODATA_DB.PUBLIC.FINAL_DATASET AS
SELECT
    o.order_id,
    o.customer_id,
    CASE
        WHEN c.customer_id IS NULL
             AND o.customer_id IS NOT NULL
        THEN 'Orphan Customer'

        WHEN c.email IS NULL
             AND c.phone IS NULL
             AND c.country_code IS NULL
        THEN 'Invalid Customer'

        ELSE COALESCE(c.email, 'Unknown Customer')
    END AS customer_contact,
    COALESCE(c.country_code, 'UNKNOWN') AS country_code,
    o.product_id,
    COALESCE(p.product_name, 'Unknown Product') AS product_name,
    COALESCE(p.category, 'Unknown') AS category,
    UPPER(o.currency) AS standardized_currency,
    o.amount,
    o.amount_usd,
    o.created_at AS order_created_at
FROM PC_HEVODATA_DB.PUBLIC.ORDERS_CLEAN o
LEFT JOIN PC_HEVODATA_DB.PUBLIC.CUSTOMERS_CLEAN_FINAL c
    ON o.customer_id = c.customer_id
LEFT JOIN PC_HEVODATA_DB.PUBLIC.PRODUCTS_CLEAN p
    ON o.product_id = p.product_id;



SELECT * 
FROM PC_HEVODATA_DB.PUBLIC.FINAL_DATASET;
