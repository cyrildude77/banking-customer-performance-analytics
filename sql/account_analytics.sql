#Account protfolio by type
SELECT
    account_type,
    COUNT(*) AS account_count,
    SUM(balance) AS total_balance,
    AVG(balance) AS avg_balance
FROM accounts
GROUP BY account_type
ORDER BY total_balance DESC;


# Account status
#	This gives us:
#- Active accounts
#- Closed accounts
#- Dormant accounts
#- etc.
#The percentage is important because raw counts alone don't tell us how significant a status is.
SELECT
    status,
    COUNT(*) AS account_count,
    SUM(balance) AS total_balance,
    ROUND(
        100.0 * COUNT(*) / (SELECT COUNT(*) FROM accounts),
        2
    ) AS percentage_of_accounts
FROM accounts
GROUP BY status
ORDER BY account_count DESC;


#branch deposit performance
SELECT
    b.branch_id,
    b.branch_name,
    b.city,
    b.state,
    COUNT(DISTINCT a.account_id) AS account_count,
    COUNT(DISTINCT a.customer_id) AS customer_count,
    SUM(a.balance) AS total_balance,
    AVG(a.balance) AS avg_account_balance
FROM accounts a
JOIN branches b
    ON a.branch_id = b.branch_id
GROUP BY
    b.branch_id,
    b.branch_name,
    b.city,
    b.state
ORDER BY total_balance DESC;