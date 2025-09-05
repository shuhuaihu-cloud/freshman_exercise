WITH user_orders AS (
    SELECT
        o.user_id,
        o.platform,
        u.gender,
        CASE
            WHEN EXTRACT(YEAR FROM o.order_date) - EXTRACT(YEAR FROM u.birth_date) < 25 THEN '<25'
            WHEN EXTRACT(YEAR FROM o.order_date) - EXTRACT(YEAR FROM u.birth_date) BETWEEN 25 AND 29 THEN '25-30'
            WHEN EXTRACT(YEAR FROM o.order_date) - EXTRACT(YEAR FROM u.birth_date) BETWEEN 30 AND 39 THEN '30-40'
            WHEN EXTRACT(YEAR FROM o.order_date) - EXTRACT(YEAR FROM u.birth_date) BETWEEN 40 AND 49 THEN '40-50'
            WHEN EXTRACT(YEAR FROM o.order_date) - EXTRACT(YEAR FROM u.birth_date) BETWEEN 50 AND 59 THEN '50-60'
            ELSE '>=60'
        END AS age_bucket,
        o.order_date,
        LAG(o.order_date) OVER (PARTITION BY o.user_id ORDER BY o.order_date) AS prev_date
    FROM `your_project.your_dataset.orders` o
    JOIN `your_project.your_dataset.users` u
      ON o.user_id = u.user_id
    WHERE o.order_date >= DATE('2024-01-01')
)
, intervals AS (
    SELECT
        platform,
        gender,
        age_bucket,
        DATE_DIFF(order_date, prev_date, DAY) AS repurchase_days
    FROM user_orders
    WHERE prev_date IS NOT NULL
)
SELECT
    platform,
    gender,
    age_bucket,
    APPROX_QUANTILES(repurchase_days, 4)[OFFSET(1)] AS q1,  -- 25th percentile
    APPROX_QUANTILES(repurchase_days, 4)[OFFSET(2)] AS q2,  -- 50th percentile
    APPROX_QUANTILES(repurchase_days, 4)[OFFSET(3)] AS q3,  -- 75th percentile
    AVG(repurchase_days) AS avg_days
FROM intervals
GROUP BY platform, gender, age_bucket
ORDER BY platform, gender, age_bucket;
