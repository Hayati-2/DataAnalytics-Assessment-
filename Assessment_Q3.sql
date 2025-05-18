WITH LatestTransactions AS (
    -- CTE to find the latest transaction date for each plan
    SELECT 
        p.id AS plan_id,
        MAX(s.transaction_date) AS last_transaction_date
    FROM plans_plan p
    LEFT JOIN savings_savingsaccount s ON p.id = s.plan_id
    WHERE 
        (p.is_regular_savings = 1 OR p.is_a_fund = 1)  -- Only active savings or investment accounts
    GROUP BY p.id
)
SELECT 
    p.id AS plan_id,
    p.owner_id,
    CASE 
        WHEN p.is_regular_savings = 1 THEN 'Savings'
        WHEN p.is_a_fund = 1 THEN 'Investment'
        ELSE 'Other'
    END AS type,
    lt.last_transaction_date,
    -- Count the number of days with no inflow transactions within the 365-day period
    COUNT(s.transaction_date) AS inactivity_days
FROM plans_plan p
JOIN savings_savingsaccount s ON p.id = s.plan_id
JOIN LatestTransactions lt ON p.id = lt.plan_id
WHERE 
    s.confirmed_amount = 0  -- No inflow transactions
    AND s.transaction_date BETWEEN DATE_SUB(lt.last_transaction_date, INTERVAL 365 DAY) 
                               AND lt.last_transaction_date
GROUP BY p.id, p.owner_id, type, lt.last_transaction_date
ORDER BY inactivity_days DESC;
