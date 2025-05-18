-- This query identifies inactive savings or investment plans that haven't had any confirmed transaction in over 365 days.

SELECT 
	S.plan_id, 
    S.owner_id, 
	CASE                   
		WHEN P.is_regular_savings = 1 THEN 'saving'
		WHEN P.is_a_fund = 1 THEN 'investment' 
		ELSE 'inactive'
	END AS type,          -- To categorize the plan type as 'saving', 'investment', or 'inactive'
	MAX(transaction_date) AS last_transaction_date, DATEDIFF(CURRENT_DATE(), 
    MAX(transaction_date)) AS inactivity_days
FROM plans_plan AS P
JOIN savings_savingsaccount AS S
ON S.plan_id = P.id
WHERE S.confirmed_amount > 0                      -- Considering plans with confirmed deposits 
AND (P.is_regular_savings = 1 OR P.is_a_fund = 1) -- And Limiting to regular savings or investment plans only
GROUP BY S.plan_id, S.owner_id, type
HAVING DATEDIFF(CURRENT_DATE(), MAX(transaction_date)) >= 365  -- returning plans with no activity in 365 days
ORDER BY inactivity_days;