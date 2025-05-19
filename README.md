# SQL Assessment – Data Analytics Task

This repository contains my solutions for a four-question SQL assessment. Each query answers a real-world business question using SQL. 
I’ve also added clear explanations to help anyone, including beginners or non-analysts, understand what I did and why.

---

## 📁 Repository Structure

	DataAnalytics-Assessment/
	│
	├── Assessment_Q1.sql
	├── Assessment_Q2.sql
	├── Assessment_Q3.sql
	├── Assessment_Q4.sql
	│
	└── README.md



---

## ✅ Assessment Overview & Explanations

	### 🟡 Assessment 1 – High-Value Customers with Multiple Products

	**📌 Objective:**  
		To find users who have both a savings and an investment plan, and sort them by how much they’ve deposited overall.

	**🔍 My Approach:**  
		- I used nested queries to count how many savings and investment plans each customer owns.
		- Then using JOIN statements, the counts were merged with user data from the user_customuser table.
		- I calculated total deposits and withdrawals per user using SUM(), and computed net deposits by subtracting withdrawals from the deposits
		- I only included users who have at least one savings **AND** one investment plan.	
		- Finally, I sorted the results by net deposits from highest to lowest
		

	**⚠️ Challenge:**  
		- It was a bit tricky joining many tables and making sure that users who had made no transactions yet didn’t get left out. 
		- I used `LEFT JOIN` and `COALESCE` to make sure everyone was included even if they had no deposits or withdrawals yet as long as they had at least one savings and one investment plan.

---

	### 🟡 Assessment 2 – Transaction Frequency Analysis

	**📌 Objective:**  
		To group customers based on how often they make transactions in a month (e.g., frequent, occasional, or rare users).

	**🔍 My Approach:**  
		- I used a nested query to count transactions per customer per month.
		- Then, I calculated the average monthly transactions per user using AVG().
		- I applied a CASE WHEN statement to label customers into the 3 frequency categories.
		- Based on that average, I grouped users by applying a CASE WHEN statement to label customers into the 3 frequency categories:
  			- High Frequency: 10+ transactions/month
  			- Medium Frequency: 3–9 transactions/month
 			  - Low Frequency: 2 or fewer/month

	**⚠️ Challenge:**  
		- The most challenging part was ensuring that the average monthly transaction were not double counted across different years.
		- I had to group the data by both year and month to get the right monthly averages.

---

	### 🟡 Assessment 3 – Account Inactivity Alert

	**📌 Objective:**  
		To identify all active accounts (savings or investment) with no transaction in the past 1 year.

	**🔍 My Approach:**  
		- I joined the plans_plan and savings_savingsaccount tables.
		- Used a WHERE clause to filter for active accounts only (either savings or investment plans).
		- I used MAX(transaction_date) to find the latest transaction per plan and DATEDIFF() to calculate the number of days since that date.
		- Only returned plans with 365+ days of inactivity.


	**⚠️ Challenge:**  
		- I made sure to include only plans that had some money added to them by checking that confirmed_amount > 0. This helped focus on accounts that are still technically active but haven’t been used in a long time.
		- I also used a CASE WHEN statement to correctly label whether each plan was a savings or investment plan.

---

	### 🟡 Assessment 4 – Customer Lifetime Value (CLV) Estimation

	**📌 Objective:**  
		To estimate each customer’s CLV based on how long they’ve been with the company and how much they’ve transacted.

	**🔍 My Approach:**  
		- I used TIMESTAMPDIFF() to calculate how long each user has been active (In months) by comparing today’s date to when they joined.
		- Then, I used SUM() to add up all confirmed deposits for each user.
		- Next, I calculated the CLV using the formula:
  
 			CLV = (total_transactions / tenure) * 12 * profit_margin
			(profit margin = 0.1% or 0.001)
    			This assumes that profit per transaction is 0.1%.

		- Finally, I sorted users by their estimated CLV.

	**⚠️ Challenge:**  
		- The formula involved several steps (tenure, total deposits, and CLV). I had to ensure there was no division by zero and round the numbers for easy reading.

---

## 💬 Final Notes

	- These queries help support decision-making across sales, marketing, finance, and operations.
	- All queries are written and tested using MySQL Workbench.
	- I’ve used simple SQL techniques like JOINs, GROUP BY, and aggregate functions (SUM, COUNT, etc.).
	- The code is clearly formatted and commented so anyone can follow along.

---

Thanks for checking out my project! Feel free to reach out if you’d like more details or explanations.

