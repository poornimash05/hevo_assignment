CREATE OR REPLACE TABLE PC_HEVODATA_DB.PUBLIC.ORDERS_CLEAN AS
WITH base AS (
    SELECT
        order_id,
        customer_id,
        product_id,
        COALESCE(UPPER(currency), 'USD') AS currency,
        amount,
        created_at
    FROM PC_HEVODATA_DB.PUBLIC.ORDERS_RAW
),
median_per_customer AS (
    SELECT
        customer_id,
        MEDIAN(amount) AS median_amount
    FROM base
    GROUP BY customer_id
),
amount_fixed AS (
    SELECT
        b.order_id,
        b.customer_id,
        b.product_id,
        b.currency,

        CASE
            WHEN b.amount < 0 THEN 0
            WHEN b.amount IS NULL THEN COALESCE(m.median_amount, 0)
            ELSE b.amount
        END AS amount,
        b.created_at
    FROM base b
    LEFT JOIN median_per_customer m
        ON b.customer_id = m.customer_id
),
deduped AS (
    SELECT
        *,
        ROW_NUMBER() OVER (
            PARTITION BY order_id
            ORDER BY created_at DESC
        ) AS rn
    FROM amount_fixed
)
SELECT
    order_id,
    customer_id,
    product_id,
    currency,
    amount,
    created_at,
    CASE
        WHEN currency = 'USD' THEN amount
        WHEN currency = 'INR' THEN amount * 0.012
        WHEN currency = 'SGD' THEN amount * 0.74
        WHEN currency = 'EUR' THEN amount * 1.08
        ELSE amount
    END AS amount_usd
FROM deduped
WHERE rn = 1
ORDER BY order_id;

SELECT * FROM PC_HEVODATA_DB.PUBLIC.ORDERS_CLEAN ORDER BY order_id;
