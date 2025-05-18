SELECT 
    u.id AS customer_id,
    CONCAT(u.first_name, ' ', u.last_name) AS name,
    PERIOD_DIFF(EXTRACT(YEAR_MONTH FROM CURDATE()), EXTRACT(YEAR_MONTH FROM u.date_joined)) AS tenure_months,  -- total number of months the from date joined to current date
    COUNT(s.id) AS total_transactions,
    -- total transaction value divided by customer tenure 
    ROUND(
        (SUM(s.confirmed_amount) / NULLIF(PERIOD_DIFF(EXTRACT(YEAR_MONTH FROM CURDATE()), EXTRACT(YEAR_MONTH FROM u.date_joined)), 0)) 
        * 12 
        * 0.001,
        2
    ) AS estimated_clv  
FROM users_customuser u
LEFT JOIN savings_savingsaccount s ON u.id = s.owner_id
GROUP BY u.id, u.first_name, u.last_name, u.date_joined
ORDER BY estimated_clv DESC;
