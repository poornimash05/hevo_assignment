CREATE OR REPLACE VIEW PC_HEVODATA_DB.PUBLIC.CUSTOMERS_CLEAN AS
WITH ranked_customers AS (
    SELECT
        customer_id,
        LOWER(email) AS email,
        CASE
            WHEN REGEXP_LIKE(phone, '^[0-9]{10}$') THEN phone
            ELSE 'Unknown'
        END AS phone,
        country_code,
        created_at,
        updated_at,
        ROW_NUMBER() OVER (
            PARTITION BY customer_id
            ORDER BY updated_at DESC NULLS LAST
        ) AS rn
    FROM PC_HEVODATA_DB.PUBLIC.CUSTOMERS_RAW
)
SELECT
    customer_id,
    email,
    phone,
    country_code,
    created_at
FROM ranked_customers
WHERE rn = 1;

SELECT * 
FROM PC_HEVODATA_DB.PUBLIC.CUSTOMERS_CLEAN;
