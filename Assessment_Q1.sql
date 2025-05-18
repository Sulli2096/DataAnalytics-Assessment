-- To identify users who have both savings and investment plans

SELECT 
	U.id AS owner_id, 
    CONCAT(U.first_name, ' ', U.last_name) AS name, 
    SC.savings_count,                  -- Count of regular savings plans
	IC.investment_count,                -- Count of investment plans
    ROUND(COALESCE(TD.deposits, 0) - COALESCE(WT.withdrawals,0)) AS total_deposits  -- Net deposits = deposits - withdrawals
FROM users_customuser AS U

--  obtaining the count of savings plans per user
JOIN (
	SELECT 
		owner_id, 
        COUNT(*) AS savings_count
    FROM plans_plan 
    WHERE is_regular_savings = 1 
    GROUP BY owner_id
) AS SC ON U.id = SC.owner_id    -- Aggregate of Savings Count (SC)

--  obtaining the count of investment plans per user
JOIN (
	SELECT 
		owner_id, 
        COUNT(*) AS investment_count
    FROM plans_plan 
    WHERE is_a_fund = 1 
    GROUP BY owner_id
) AS IC ON U.id = IC.owner_id      -- Aggregate of Investment Count (IC)

-- obtaining all users with a savings and investment account whether a deposit has been made or not
LEFT JOIN(         
	SELECT 
		P.owner_id, 
        SUM(S.confirmed_amount) AS deposits
    FROM plans_plan AS P
    JOIN savings_savingsaccount AS S
    ON S.plan_id = P.id
    GROUP BY P.owner_id
) AS TD ON U.id = TD.owner_id    -- Sum of Total deposits (TD) per user

-- Obtaining total withdrawal amount per user
LEFT JOIN (
    SELECT 
		S.owner_id, 
        SUM(W.amount_withdrawn) AS withdrawals
    FROM savings_savingsaccount AS S
    JOIN withdrawals_withdrawal AS W ON W.owner_id = S.owner_id
    GROUP BY S.owner_id
) AS WT ON U.id = WT.owner_id       -- Sum of withdrawals (WT) per user

ORDER BY total_deposits DESC;



