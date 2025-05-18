WITH user_plan_summary AS (
    SELECT 
       p.owner_id AS owner_id,
      CONCAT(u.first_name, ' ', u.last_name) AS name,
        COUNT(DISTINCT CASE WHEN p.is_regular_savings = 1 THEN p.id END) AS savings_count,
        COUNT(DISTINCT CASE WHEN p.is_a_fund = 1 THEN p.id END) AS investment_count,
        SUM(s.confirmed_amount) AS total_deposits
    FROM users_customuser u
    JOIN plans_plan p ON u.id = p.owner_id
    JOIN savings_savingsaccount s ON p.id = s.plan_id
    GROUP BY u.id, u.first_name, u.last_name
)

SELECT *
FROM user_plan_summary
WHERE savings_count > 0 AND investment_count > 0
ORDER BY total_deposits ASC;


        

