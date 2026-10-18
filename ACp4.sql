-- 1. Orders above 200
SELECT * FROM orders WHERE amount > 200;
-- Returns 3 rows: 250, 980, 300

-- 2. Orders and revenue per city
SELECT c.city, COUNT(o.id) AS orders, COALESCE(SUM(o.amount), 0) AS revenue
FROM customers c
LEFT JOIN orders o ON o.customer_id = c.id
GROUP BY c.city;
-- Mumbai: 4 orders, 715.5. Delhi: 1, 980. Pune: 0, 0.

-- 3. HAVING: customers who spent more than 350 in total
SELECT c.name, SUM(o.amount) AS total
FROM customers c
JOIN orders o ON o.customer_id = c.id
GROUP BY c.name
HAVING SUM(o.amount) > 350;
-- Ravi and Asha

-- 4. CASE WHEN: label each order by size
SELECT id, amount,
  CASE WHEN amount >= 500 THEN 'big'
       WHEN amount >= 100 THEN 'medium'
       ELSE 'small' END AS size
FROM orders;

-- 5. Latest order per customer (ROW_NUMBER)
SELECT name, order_date, amount FROM (
  SELECT c.name, o.order_date, o.amount,
         ROW_NUMBER() OVER
