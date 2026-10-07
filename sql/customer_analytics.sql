# counts how much people have how much accounts
WITH customer_accounts AS (
    SELECT
        c.customer_id,
        COUNT(a.account_id) AS account_count
    FROM customers c
    LEFT JOIN accounts a
        ON c.customer_id = a.customer_id
    GROUP BY c.customer_id
)

SELECT
    account_count,
    COUNT(*) AS customer_count
FROM customer_accounts
GROUP BY account_count
ORDER BY account_count;

# this counts how many cust have accounts,loans,cards
SELECT
    c.customer_id,
    c.name,

    COUNT(DISTINCT a.account_id) AS account_count,
    COUNT(DISTINCT ca.card_id) AS card_count,
    COUNT(DISTINCT l.loan_id) AS loan_count

FROM customers c

LEFT JOIN accounts a
    ON c.customer_id = a.customer_id

LEFT JOIN cards ca
    ON c.customer_id = ca.customer_id

LEFT JOIN loans l
    ON c.customer_id = l.customer_id

GROUP BY
    c.customer_id,
    c.name;
    
# customer's fiancial value
SELECT
    c.customer_id,
    c.name,
    c.city,
    c.state,
    c.occupation,
    c.annual_income,
    c.credit_score,

    COALESCE(a.total_balance, 0) AS total_balance,
    COALESCE(l.total_loan_amount, 0) AS total_loan_amount,
    COALESCE(ct.total_card_spend, 0) AS total_card_spend

FROM customers c

LEFT JOIN (
    SELECT
        customer_id,
        SUM(balance) AS total_balance
    FROM accounts
    GROUP BY customer_id
) a
    ON c.customer_id = a.customer_id

LEFT JOIN (
    SELECT
        customer_id,
        SUM(loan_amount) AS total_loan_amount
    FROM loans
    GROUP BY customer_id
) l
    ON c.customer_id = l.customer_id

LEFT JOIN (
    SELECT
        ca.customer_id,
        SUM(ct.amount) AS total_card_spend
    FROM card_transactions ct
    JOIN cards ca
        ON ct.card_id = ca.card_id
    GROUP BY ca.customer_id
) ct
    ON c.customer_id = ct.customer_id;
    
#Top 20 customers by financial exposure
SELECT
    c.customer_id,
    c.name,
    c.city,
    c.state,
    COALESCE(a.total_balance, 0) AS total_balance,
    COALESCE(l.total_loan_amount, 0) AS total_loan_amount,

    COALESCE(a.total_balance, 0)
    + COALESCE(l.total_loan_amount, 0) AS total_financial_exposure

FROM customers c

LEFT JOIN (
    SELECT
        customer_id,
        SUM(balance) AS total_balance
    FROM accounts
    GROUP BY customer_id
) a
    ON c.customer_id = a.customer_id

LEFT JOIN (
    SELECT
        customer_id,
        SUM(loan_amount) AS total_loan_amount
    FROM loans
    GROUP BY customer_id
) l
    ON c.customer_id = l.customer_id

ORDER BY total_financial_exposure DESC
LIMIT 20;