CREATE OR REPLACE VIEW customers_clean AS
SELECT
    id,
    LOWER(email) AS email,
    SPLIT_PART(email, '@', 1) AS username,
FROM customers;

select * from pc_hevodata_db.public.customers_clean;
