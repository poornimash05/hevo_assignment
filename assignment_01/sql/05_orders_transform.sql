CREATE OR REPLACE view pc_hevodata_db.public.order_events AS
SELECT
   ID AS ORDER_ID,
   CASE
       WHEN STATUS = 'placed' THEN 'order_placed'
       WHEN STATUS = 'shipped' THEN 'order_shipped'
       WHEN STATUS = 'delivered' THEN 'order_delivered'
       WHEN STATUS = 'cancelled' THEN 'order_cancelled'
       ELSE 'order_unknown'
   END AS EVENT_TYPE,
   CURRENT_TIMESTAMP() AS PROCESSED_AT
FROM pc_hevodata_db.public.ORDERS;

select * from pc_hevodata_db.public.order_events;

