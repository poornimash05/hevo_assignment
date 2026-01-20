CREATE OR REPLACE TABLE PC_HEVODATA_DB.PUBLIC.PRODUCTS_CLEAN AS
SELECT
    product_id,
    INITCAP(product_name) AS product_name,
    INITCAP(category) AS category,
    CASE
        WHEN active_flag = 'N' THEN 'Discontinued Product'
        ELSE 'Active Product'
    END AS product_status
FROM PC_HEVODATA_DB.PUBLIC.PRODUCTS_RAW;

SELECT * FROM PC_HEVODATA_DB.PUBLIC.PRODUCTS_CLEAN ORDER BY product_id;
