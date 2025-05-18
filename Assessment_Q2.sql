WITH transaction_counts AS (
    SELECT 
        u.id,
        COUNT(*) AS total_transactions,
        PERIOD_DIFF(
            EXTRACT(YEAR_MONTH FROM MAX(s.transaction_date)),
            EXTRACT(YEAR_MONTH FROM MIN(s.transaction_date))
        ) + 1 AS months_active
    FROM savings_savingsaccount s
      JOIN users_customuser u ON u.id = tc.owner_id
    GROUP BY s.owner_id
),
average_monthly_tx AS (
    SELECT 
        u.id AS user_id,
        tc.total_transactions,
        tc.months_active,
        ROUND(tc.total_transactions / NULLIF(tc.months_active, 0), 2) AS avg_tx_per_month
    FROM transaction_counts tc
  
),
categorized_users AS (
    SELECT *,
        CASE
            WHEN avg_tx_per_month >= 10 THEN 'High Frequency'
            WHEN avg_tx_per_month BETWEEN 3 AND 9 THEN 'Medium Frequency'
            ELSE 'Low Frequency'
        END AS frequency_category
    FROM average_monthly_tx
)

SELECT 
    frequency_category,
    COUNT(*) AS customer_count,
    ROUND(AVG(avg_tx_per_month), 2) AS avg_transactions_per_month
FROM categorized_users
GROUP BY frequency_category
ORDER BY FIELD(frequency_category, 'High Frequency', 'Medium Frequency', 'Low Frequency');
