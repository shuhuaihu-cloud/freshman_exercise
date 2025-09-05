WITH first_order AS (
    -- 每個用戶的首次完單時間
    SELECT
        user_id,
        MIN(order_time) AS first_order_time
    FROM orders
    GROUP BY user_id
),

order_with_user AS (
    -- 把訂單 join 註冊完成 / 審核完成時間
    SELECT
        o.order_id,
        o.user_id,
        o.platform,
        o.order_time,
        r.register_time,
        a.approve_time,
        f.first_order_time,
        CASE 
            WHEN o.order_time = f.first_order_time THEN 1 
            ELSE 0 
        END AS is_new_user
    FROM orders o
    LEFT JOIN registers r ON o.user_id = r.user_id
    LEFT JOIN approvals a ON o.user_id = a.user_id
    JOIN first_order f ON o.user_id = f.user_id
),

period_flag AS (
    -- 依完單時間區分統計區間 (1個月內、1~3個月、3~6個月、6~12個月)
    SELECT
        o.*,
        CASE 
            WHEN o.order_time >= DATE_TRUNC('month', CURRENT_DATE) 
                 AND o.order_time < DATE_TRUNC('month', CURRENT_DATE) + INTERVAL '1 month'
                THEN '1個月內'
            WHEN o.order_time >= DATE_TRUNC('month', CURRENT_DATE) - INTERVAL '3 month'
                 AND o.order_time < DATE_TRUNC('month', CURRENT_DATE)
                THEN '1~3個月'
            WHEN o.order_time >= DATE_TRUNC('month', CURRENT_DATE) - INTERVAL '6 month'
                 AND o.order_time < DATE_TRUNC('month', CURRENT_DATE) - INTERVAL '3 month'
                THEN '3~6個月'
            WHEN o.order_time >= DATE_TRUNC('month', CURRENT_DATE) - INTERVAL '12 month'
                 AND o.order_time < DATE_TRUNC('month', CURRENT_DATE) - INTERVAL '6 month'
                THEN '6~12個月'
        END AS period
    FROM order_with_user o
),

agg AS (
    -- 算新舊戶比例 + 註冊/審核到完單平均時長
    SELECT
        platform,
        period,
        SUM(CASE WHEN is_new_user = 1 THEN 1 ELSE 0 END) AS new_user_orders,
        SUM(CASE WHEN is_new_user = 0 THEN 1 ELSE 0 END) AS old_user_orders,
        -- 平均註冊→完單時長 (僅新戶)
        AVG(
            CASE WHEN is_new_user = 1 
                 THEN DATE_PART('day', order_time - register_time) 
            END
        ) AS avg_reg_to_order_days,
        -- 平均審核→完單時長 (僅新戶)
        AVG(
            CASE WHEN is_new_user = 1 
                 THEN DATE_PART('day', order_time - approve_time) 
            END
        ) AS avg_approve_to_order_days
    FROM period_flag
    WHERE period IS NOT NULL
    GROUP BY platform, period
)

SELECT
    platform,
    period,
    ROUND(100.0 * new_user_orders / (new_user_orders + old_user_orders), 1) || '%' AS new_user_ratio,
    ROUND(100.0 * old_user_orders / (new_user_orders + old_user_orders), 1) || '%' AS old_user_ratio,
    ROUND(avg_reg_to_order_days, 1) || '天' AS avg_reg_to_order,
    ROUND(avg_approve_to_order_days, 1) || '天' AS avg_approve_to_order
FROM agg
ORDER BY platform, 
         CASE period
            WHEN '1個月內' THEN 1
            WHEN '1~3個月' THEN 2
            WHEN '3~6個月' THEN 3
            WHEN '6~12個月' THEN 4
         END;
