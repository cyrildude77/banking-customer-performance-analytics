# branch overview
SELECT
    b.branch_id,
    b.branch_name,
    b.city,
    b.state,
    COUNT(DISTINCT a.customer_id) AS customer_count,
    COUNT(DISTINCT a.account_id) AS account_count,
    COALESCE(SUM(a.balance), 0) AS total_balance
FROM branches b
LEFT JOIN accounts a
    ON b.branch_id = a.branch_id
GROUP BY
    b.branch_id,
    b.branch_name,
    b.city,
    b.state
ORDER BY total_balance DESC;




#branch loan portfolio
SELECT
    b.branch_id,
    b.branch_name,
    b.city,
    b.state,
    COUNT(l.loan_id) AS loan_count,
    COALESCE(SUM(l.loan_amount), 0) AS total_loan_amount,
    ROUND(AVG(l.loan_amount), 2) AS avg_loan_amount
FROM branches b
LEFT JOIN loans l
    ON b.branch_id = l.branch_id
GROUP BY
    b.branch_id,
    b.branch_name,
    b.city,
    b.state
ORDER BY total_loan_amount DESC;





# employee distribution and salary
SELECT
    b.branch_id,
    b.branch_name,
    b.city,
    b.state,
    COUNT(e.employee_id) AS employee_count,
    ROUND(AVG(e.salary), 2) AS avg_salary,
    ROUND(MIN(e.salary), 2) AS min_salary,
    ROUND(MAX(e.salary), 2) AS max_salary,
    ROUND(SUM(e.salary), 2) AS total_salary_cost
FROM branches b
LEFT JOIN employees e
    ON b.branch_id = e.branch_id
GROUP BY
    b.branch_id,
    b.branch_name,
    b.city,
    b.state
ORDER BY employee_count DESC;





#branch customer per employee
WITH branch_customers AS (
    SELECT
        branch_id,
        COUNT(DISTINCT customer_id) AS customer_count
    FROM accounts
    GROUP BY branch_id
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
    COALESCE(bc.customer_count, 0) AS customer_count,
    COALESCE(be.employee_count, 0) AS employee_count,
    ROUND(
        COALESCE(bc.customer_count, 0)
        / NULLIF(be.employee_count, 0),
        2
    ) AS customers_per_employee
FROM branches b
LEFT JOIN branch_customers bc
    ON b.branch_id = bc.branch_id
LEFT JOIN branch_employees be
    ON b.branch_id = be.branch_id
ORDER BY customers_per_employee DESC;





#overall branch performance scorecard
WITH branch_accounts AS (
    SELECT
        branch_id,
        COUNT(DISTINCT account_id) AS account_count,
        COUNT(DISTINCT customer_id) AS customer_count,
        SUM(balance) AS total_balance
    FROM accounts
    GROUP BY branch_id
),
branch_loans AS (
    SELECT
        branch_id,
        COUNT(*) AS loan_count,
        SUM(loan_amount) AS total_loan_amount
    FROM loans
    GROUP BY branch_id
),
branch_transactions AS (
    SELECT
        a.branch_id,
        COUNT(t.transaction_id) AS transaction_count,
        SUM(t.amount) AS transaction_value
    FROM transactions t
    JOIN accounts a
        ON t.account_id = a.account_id
    GROUP BY a.branch_id
),
branch_employees AS (
    SELECT
        branch_id,
        COUNT(*) AS employee_count,
        AVG(salary) AS avg_salary
    FROM employees
    GROUP BY branch_id
)
SELECT
    b.branch_id,
    b.branch_name,
    b.city,
    b.state,

    COALESCE(ba.customer_count, 0) AS customer_count,
    COALESCE(ba.account_count, 0) AS account_count,
    COALESCE(ba.total_balance, 0) AS total_balance,

    COALESCE(bl.loan_count, 0) AS loan_count,
    COALESCE(bl.total_loan_amount, 0) AS total_loan_amount,

    COALESCE(bt.transaction_count, 0) AS transaction_count,
    COALESCE(bt.transaction_value, 0) AS transaction_value,

    COALESCE(be.employee_count, 0) AS employee_count,
    ROUND(COALESCE(be.avg_salary, 0), 2) AS avg_salary,

    ROUND(
        COALESCE(bt.transaction_value, 0)
        / NULLIF(be.employee_count, 0),
        2
    ) AS transaction_value_per_employee,

    ROUND(
        COALESCE(bl.total_loan_amount, 0)
        / NULLIF(be.employee_count, 0),
        2
    ) AS loan_value_per_employee

FROM branches b
LEFT JOIN branch_accounts ba
    ON b.branch_id = ba.branch_id
LEFT JOIN branch_loans bl
    ON b.branch_id = bl.branch_id
LEFT JOIN branch_transactions bt
    ON b.branch_id = bt.branch_id
LEFT JOIN branch_employees be
    ON b.branch_id = be.branch_id
ORDER BY transaction_value_per_employee DESC;