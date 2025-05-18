-- CUSTOMER LIFETIME VALUE (CLV)
-- This query calculates the estimated CLVfor each customer by
-- determining user tenure (months), summing confirmed deposit transactions, and
-- calculating CLV by applying a formula.

SELECT 
	U.id AS customer_id, 
    CONCAT(U.first_name, ' ', U.last_name) AS name, 
    -- To calculate how many months each customer has been active
	TIMESTAMPDIFF(MONTH, MIN(U.date_joined), CURRENT_DATE()) AS tenure_months, 
    -- To get the total confirmed deposits made by each user
	ROUND(SUM(S.confirmed_amount), 2) AS total_transactions,  
    -- Estimated CLV: average monthly deposit * 12 months * 0.1% profit margin
	ROUND(((SUM(S.confirmed_amount)/TIMESTAMPDIFF(MONTH, MIN(U.date_joined), CURRENT_DATE())) * 12 * 0.001), 2) AS estimated_CLV  
FROM users_customuser AS U 
JOIN savings_savingsaccount As S 
ON U.id=S.owner_id
GROUP BY U.id
ORDER BY estimated_CLV DESC; 

