WITH first_order AS (
    -- 每個用戶的首次完單時間
    SELECT
        acct_id,
        MIN(booking_at) AS first_order_time
    FROM `centering-oxide-345205.prod_carplus_adw.s2g_orders_completed`
    GROUP BY acct_id
),

order_with_user AS (
    -- 把訂單 join 註冊完成 / 審核完成時間
    SELECT
        o.order_no,
        o.acct_id,
        o.order_source,
       DATE(o.booking_at),
        r.cre_dt,
        a.submit_at,
        f.first_order_time,
        o.booking_at,
        CASE 
            WHEN o.booking_at = f.first_order_time THEN 1 
            ELSE 0 
        END AS is_new_user
    FROM `centering-oxide-345205.prod_carplus_adw.s2g_orders_completed` o
    LEFT JOIN `sincere-strata-288408.adw_base.auth_carplus_users` r ON o.acct_id = CAST(r.acct_id AS string)
    LEFT JOIN `centering-oxide-345205.prod_carplus_adw.certified_document` a ON o.acct_id = a.acct_id
    JOIN first_order f ON o.acct_id = f.acct_id
),

period_flag AS (
    -- 依完單時間區分統計區間 (1個月內、1~3個月、3~6個月、6~12個月)
    SELECT
        o.*,
        CASE 
            WHEN DATE(o.booking_at) >= DATE_TRUNC(CURRENT_DATE(), month) 
                 AND DATE(o.booking_at) < DATE_TRUNC(CURRENT_DATE(), month) + INTERVAL 1 month
                THEN '1個月內'
            WHEN DATE(o.booking_at) >= DATE_TRUNC(CURRENT_DATE(), month) - INTERVAL 3 month
                 AND DATE(o.booking_at) < DATE_TRUNC(CURRENT_DATE(), month)
                THEN '1~3個月'
            WHEN DATE(o.booking_at) >= DATE_TRUNC(CURRENT_DATE(), month) - INTERVAL 6 month
                 AND DATE(o.booking_at) < DATE_TRUNC(CURRENT_DATE(), month) - INTERVAL 3 month
                THEN '3~6個月'
            WHEN DATE(o.booking_at) >= DATE_TRUNC(CURRENT_DATE(), month) - INTERVAL 12 month
                 AND DATE(o.booking_at) < DATE_TRUNC(CURRENT_DATE(), month) - INTERVAL 6 month
                THEN '6~12個月'
        END AS period
    FROM order_with_user o
),

agg AS (
    -- 算新舊戶比例 + 註冊/審核到完單平均時長
    SELECT
        order_source,
        period,
        SUM(CASE WHEN is_new_user = 1 THEN 1 ELSE 0 END) AS new_user_orders,
        SUM(CASE WHEN is_new_user = 0 THEN 1 ELSE 0 END) AS old_user_orders,
    -- 平均註冊→完單時長 (僅新戶)
    AVG(
        CASE WHEN is_new_user = 1 
            THEN TIMESTAMP_DIFF(booking_at, TIMESTAMP(cre_dt), DAY)
        END
    ) AS avg_reg_to_order_days,

    -- 平均審核→完單時長 (僅新戶)
    AVG(
        CASE WHEN is_new_user = 1 
            THEN TIMESTAMP_DIFF(booking_at, TIMESTAMP(submit_at), DAY)
        END
    ) AS avg_approve_to_order_days
    FROM period_flag
    WHERE period IS NOT NULL
    GROUP BY order_source, period
)

SELECT
    order_source,
    period,
    ROUND(100.0 * new_user_orders / (new_user_orders + old_user_orders), 1) || '%' AS new_user_ratio,
    ROUND(100.0 * old_user_orders / (new_user_orders + old_user_orders), 1) || '%' AS old_user_ratio,
    ROUND(avg_reg_to_order_days, 1) || '天' AS avg_reg_to_order,
    ROUND(avg_approve_to_order_days, 1) || '天' AS avg_approve_to_order
FROM agg
ORDER BY order_source, 
         CASE period
            WHEN '1個月內' THEN 1
            WHEN '1~3個月' THEN 2
            WHEN '3~6個月' THEN 3
            WHEN '6~12個月' THEN 4
         END;
