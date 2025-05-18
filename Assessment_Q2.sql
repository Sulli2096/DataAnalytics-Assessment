-- This query groups customers based on how frequently they transact each month
-- Categories: High, Medium, Low frequency
-- It returns the number of customers per category and the average number of transactions per month for each category

SELECT 
	frequency_category, 
    COUNT(owner_id) AS customer_count,
    ROUND(AVG(avg_transactions_per_month), 2) AS avg_transactions_per_month
FROM (
	SELECT 
		owner_id, 
        AVG(transactions) AS avg_transactions_per_month,
		CASE
			WHEN AVG(CF.transactions) >= 10 THEN 'High Frequency'
			WHEN AVG(CF.transactions) BETWEEN 3 AND 9 THEN 'Medium Frequency' 
			ELSE 'Low Frequency'
		END AS frequency_category     -- Nested query to obtain frequency_category 
	FROM(
		SELECT 
			owner_id, 
            Count(*) AS transactions,          
			EXTRACT(YEAR FROM transaction_date) AS year,  
			EXTRACT(MONTH FROM transaction_date) AS month
		FROM savings_savingsaccount AS S 
         -- Grouping by both year and month to avoid monthly count being recorded multiple times over the years
		GROUP BY owner_id, EXTRACT(YEAR FROM transaction_date), EXTRACT(MONTH FROM transaction_date)       
	) AS CF     -- Nested query to obtain Frequency by month (CF = Customer Frequency)
	GROUP BY owner_id
) AS avg_transaction_per_customer -- avg_transaction_per_cutomer
GROUP BY frequency_category
ORDER BY avg_transactions_per_month DESC;


