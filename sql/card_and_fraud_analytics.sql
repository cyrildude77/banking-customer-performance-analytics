# overall card fraud
SELECT
    COUNT(*) AS total_transactions,
    SUM(CASE WHEN is_fraud = 1 THEN 1 ELSE 0 END) AS fraud_transactions,
    SUM(CASE WHEN is_fraud = 1 THEN amount ELSE 0 END) AS fraud_amount,
    ROUND(
        100.0 * SUM(CASE WHEN is_fraud = 1 THEN 1 ELSE 0 END)
        / COUNT(*),
        2
    ) AS fraud_rate_pct,
    ROUND(
        100.0 * SUM(CASE WHEN is_fraud = 1 THEN amount ELSE 0 END)
        / SUM(amount),
        2
    ) AS fraud_value_rate_pct
FROM card_transactions;



#Fraud by Merchant Category
SELECT
    merchant_category,
    COUNT(*) AS total_transactions,
    SUM(CASE WHEN is_fraud = 1 THEN 1 ELSE 0 END) AS fraud_transactions,
    SUM(CASE WHEN is_fraud = 1 THEN amount ELSE 0 END) AS fraud_amount,
    ROUND(
        100.0 * SUM(CASE WHEN is_fraud = 1 THEN 1 ELSE 0 END)
        / COUNT(*),
        2
    ) AS fraud_rate_pct
FROM card_transactions
GROUP BY merchant_category
ORDER BY fraud_rate_pct DESC;


# Top Fraud-Affected Customers
SELECT
    c.customer_id,
    c.name,
    COUNT(ct.card_txn_id) AS fraud_transactions,
    SUM(ct.amount) AS fraud_amount
FROM card_transactions ct
JOIN cards ca
    ON ct.card_id = ca.card_id
JOIN customers c
    ON ca.customer_id = c.customer_id
WHERE ct.is_fraud = 1
GROUP BY c.customer_id, c.name
ORDER BY fraud_amount DESC
LIMIT 20;



#Monthly fraud trend
SELECT
    DATE_FORMAT(txn_date, '%Y-%m') AS month,
    COUNT(*) AS total_transactions,
    SUM(CASE WHEN is_fraud = 1 THEN 1 ELSE 0 END) AS fraud_transactions,
    SUM(CASE WHEN is_fraud = 1 THEN amount ELSE 0 END) AS fraud_amount,
    ROUND(
        100.0 * SUM(CASE WHEN is_fraud = 1 THEN 1 ELSE 0 END)
        / COUNT(*),
        2
    ) AS fraud_rate_pct
FROM card_transactions
GROUP BY DATE_FORMAT(txn_date, '%Y-%m')
ORDER BY month;
