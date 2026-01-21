CREATE OR REPLACE VIEW PC_HEVODATA_DB.PUBLIC.CUSTOMERS_CLEAN_FINAL AS
SELECT
    c.customer_id,

    c.email,

    c.phone,

    COALESCE(
        cd.iso_code,
        CASE
            WHEN c.country_code IS NULL OR TRIM(c.country_code) = '' THEN NULL
            ELSE 'UNKNOWN'
        END
    ) AS country_code,

    COALESCE(
        c.created_at,
        TO_TIMESTAMP('1900-01-01 00:00:00')
    ) AS created_at

FROM PC_HEVODATA_DB.PUBLIC.CUSTOMERS_CLEAN c
LEFT JOIN PC_HEVODATA_DB.PUBLIC.COUNTRY_DIM cd
    ON UPPER(TRIM(c.country_code)) IN (
        UPPER(cd.country_name),
        UPPER(cd.iso_code),
        CASE
            WHEN cd.iso_code = 'US' THEN 'USA'
            WHEN cd.iso_code = 'US' THEN 'UNITEDSTATES'
            WHEN cd.iso_code = 'IN' THEN 'IND'
            WHEN cd.iso_code = 'SG' THEN 'SINGAPORE'
        END
    );

SELECT * 
FROM PC_HEVODATA_DB.PUBLIC.CUSTOMERS_CLEAN_FINAL;
