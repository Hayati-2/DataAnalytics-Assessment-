# DataAnalytics-Assessment-


1. High-Value Customers with Multiple Products
Scenario: The business wants to identify customers who have both a savings and an investment plan (cross-selling opportunity).
Task: Write a query to find customers with at least one funded savings plan AND one funded investment plan, sorted by total deposits.

Explanations: I used a Common Table Expression (CTE) to get customer name  from the user table and joined the plans and savings account table to be able to extract the investment plans and total deposit.


2. Transaction Frequency Analysis
Scenario: The finance team wants to analyze how often customers transact to segment them (e.g., frequent vs. occasional users).
Task: Calculate the average number of transactions per customer per month and categorize them:
"High Frequency" (≥10 transactions/month)
"Medium Frequency" (3-9 transactions/month)
"Low Frequency" (≤2 transactions/month)


Explanation: 
A CTE was used to derive the transaction count, average monthly transaction and user categories. A join was also used to be able to extract data from different tables using one query to get a result.

3. Account Inactivity Alert
Scenario: The ops team wants to flag accounts with no inflow transactions for over one year.
Task: Find all active accounts (savings or investments) with no transactions in the last 1 year (365 days) .
Tables:

Explanation: 
This question was a tricky one. I had to use a CTE to first derive the latest transaction date for each plan. I counted the inactive days with no transactions by the days with no transaction from the latest transaction date within a 365 days period.


4. Customer Lifetime Value (CLV) Estimation
Scenario: Marketing wants to estimate CLV based on account tenure and transaction volume (simplified model).
Task: For each customer, assuming the profit_per_transaction is 0.1% of the transaction value, calculate:
Account tenure (months since signup)
Total transactions
Estimated CLV (Assume: CLV = (total_transactions / tenure) * 12 * avg_profit_per_transaction)
Order by estimated CLV from highest to lowest

Eplanation: I substracted the user joined date from the current date to get the customer tenure in months. The CLV was calculated by dividing the tenure by the total transaction value of the customer. 
