WITH all_orders AS (
  -- 日租
  SELECT acct_id, order_create_dt
  FROM `centering-oxide-345205.prod_carplus_adw.srental_orders_completed`
  WHERE order_create_dt BETWEEN DATE '2020-01-01' AND DATE '2025-08-31'
 
  UNION DISTINCT
 
  -- 共享
  SELECT acct_id, DATE(booking_at)
  FROM `centering-oxide-345205.prod_carplus_adw.s2g_orders_completed`
  WHERE DATE(booking_at) BETWEEN DATE '2020-01-01' AND DATE '2025-08-31'
)
SELECT COUNT(DISTINCT o.acct_id) AS user_count
FROM all_orders o
JOIN `sincere-strata-288408.adw_base.auth_carplus_users` u
  ON o.acct_id = CAST(u.acct_id AS string)
WHERE u.gosmart_login_dt < DATE '2025-08-31'
  AND u.gosmart_login_dt IS NOT NULL;