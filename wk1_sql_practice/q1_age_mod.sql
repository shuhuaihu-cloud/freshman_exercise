WITH user_orders AS (
    SELECT
        o.acct_id,
        o.order_source_desc,
        u.cust_gender,
        CASE
            WHEN u.cust_age < 25 THEN '<25'
            WHEN u.cust_age BETWEEN 25 AND 29 THEN '25-30'
            WHEN u.cust_age BETWEEN 30 AND 39 THEN '30-40'
            WHEN u.cust_age BETWEEN 40 AND 49 THEN '40-50'
            WHEN u.cust_age BETWEEN 50 AND 59 THEN '50-60'
            ELSE '>=60'
        END AS age_bucket,
        o.order_create_dt,
        LAG(o.order_create_dt) OVER (PARTITION BY o.acct_id ORDER BY o.order_create_dt) AS prev_date
    FROM `centering-oxide-345205.prod_carplus_adw.srental_orders_completed` o
    JOIN `centering-oxide-345205.prod_carplus_adw.customers` u
      ON o.acct_id = u.acct_id
    WHERE o.order_create_dt >= DATE('2024-01-01')
      AND o.order_create_dt < DATE('2025-01-01')
)
, intervals AS (
    SELECT
        acct_id,
        order_source_desc,
        cust_gender,
        age_bucket,
        DATE_DIFF(order_create_dt, prev_date, DAY) AS repurchase_days
    FROM user_orders
    WHERE prev_date IS NOT NULL
)
SELECT
    order_source_desc,
    cust_gender,
    age_bucket,
    APPROX_QUANTILES(repurchase_days, 4)[OFFSET(1)] AS q1,  -- 25th percentile
    APPROX_QUANTILES(repurchase_days, 4)[OFFSET(2)] AS q2,  -- 50th percentile
    APPROX_QUANTILES(repurchase_days, 4)[OFFSET(3)] AS q3,  -- 75th percentile
    AVG(repurchase_days) AS avg_days,
    COUNT(DISTINCT acct_id) AS id_count,
    COUNT(*) AS agg_count
FROM intervals
GROUP BY order_source_desc, cust_gender, age_bucket
ORDER BY order_source_desc, cust_gender, age_bucket;
