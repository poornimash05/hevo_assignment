CREATE OR REPLACE VIEW customers_clean AS
SELECThttps://github.com/poornimash05/hevo_assignment/edit/main/assignment_01/sql/04_customers_transform.sql
    id,
    LOWER(email) AS email,
    SPLIT_PART(email, '@', 1) AS username,
FROM customers;

select * from pc_hevodata_db.public.customers_clean;
