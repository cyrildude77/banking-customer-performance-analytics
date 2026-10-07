#transaction performance by year
SELECT
    YEAR(txn_date) AS year,
    COUNT(*) AS transaction_count,
    SUM(amount) AS transaction_value,
    AVG(amount) AS avg_transaction_value
FROM transactions
GROUP BY YEAR(txn_date)
ORDER BY year;



#transaction type performance
SELECT
    txn_type,
    COUNT(*) AS transaction_count,
    SUM(amount) AS transaction_value,

    ROUND(
        100.0 * COUNT(*) / (SELECT COUNT(*) FROM transactions),
        2
    ) AS transaction_share_pct,

    ROUND(
        100.0 * SUM(amount) /
        (SELECT SUM(amount) FROM transactions),
        2
    ) AS value_share_pct

FROM transactions
GROUP BY txn_type
ORDER BY transaction_value DESC;



#channel performance
SELECT
    channel,
    COUNT(*) AS transaction_count,
    SUM(amount) AS transaction_value,
    AVG(amount) AS avg_transaction_value,

    ROUND(
        100.0 * COUNT(*) /
        (SELECT COUNT(*) FROM transactions),
        2
    ) AS transaction_share_pct,

    ROUND(
        100.0 * SUM(amount) /
        (SELECT SUM(amount) FROM transactions),
        2
    ) AS value_share_pct

FROM transactions
GROUP BY channel
ORDER BY transaction_value DESC;


#most valuable branches by transactions
SELECT
    b.branch_id,
    b.branch_name,
    b.city,
    b.state,

    COUNT(t.transaction_id) AS transaction_count,

    SUM(t.amount) AS transaction_value,

    ROUND(AVG(t.amount), 2) AS avg_transaction_value

FROM transactions t

JOIN accounts a
    ON t.account_id = a.account_id

JOIN branches b
    ON a.branch_id = b.branch_id

GROUP BY
    b.branch_id,
    b.branch_name,
    b.city,
    b.state

ORDER BY transaction_value DESC
LIMIT 20;



# branch efficiency
WITH branch_transactions AS (
    SELECT
        a.branch_id,
        SUM(t.amount) AS transaction_value
    FROM transactions t
    JOIN accounts a
        ON t.account_id = a.account_id
    GROUP BY a.branch_id
),

branch_employees AS (
    SELECT
        branch_id,
        COUNT(*) AS employee_count
    FROM employees
    GROUP BY branch_id
)

SELECT
    b.branch_id,
    b.branch_name,
    b.city,
    b.state,

    COALESCE(bt.transaction_value, 0) AS transaction_value,
    COALESCE(be.employee_count, 0) AS employee_count,

    ROUND(
        COALESCE(bt.transaction_value, 0) /
        NULLIF(be.employee_count, 0),
        2
    ) AS transaction_value_per_employee

FROM branches b

LEFT JOIN branch_transactions bt
    ON b.branch_id = bt.branch_id

LEFT JOIN branch_employees be
    ON b.branch_id = be.branch_id

ORDER BY transaction_value_per_employee DESC;