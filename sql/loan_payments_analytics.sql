# overall loan payment performance
SELECT
    COUNT(*) AS total_payments,
    COUNT(DISTINCT loan_id) AS loans_with_payments,
    SUM(amount_paid) AS total_amount_paid,
    SUM(principal_component) AS total_principal_paid,
    SUM(interest_component) AS total_interest_paid,
    AVG(amount_paid) AS avg_payment,
    SUM(CASE WHEN late_payment_flag = 1 THEN 1 ELSE 0 END) AS late_payments,
    ROUND(
        100.0 * SUM(CASE WHEN late_payment_flag = 1 THEN 1 ELSE 0 END)
        / COUNT(*),
        2
    ) AS late_payment_rate_pct
FROM loan_payments;



#loan payment performance by loan type
SELECT
    l.loan_type,
    COUNT(lp.payment_id) AS payment_count,
    COUNT(DISTINCT lp.loan_id) AS loans_with_payments,
    SUM(lp.amount_paid) AS total_amount_paid,
    SUM(lp.principal_component) AS principal_paid,
    SUM(lp.interest_component) AS interest_paid,
    ROUND(AVG(lp.amount_paid), 2) AS avg_payment,
    SUM(CASE WHEN lp.late_payment_flag = 1 THEN 1 ELSE 0 END) AS late_payments,
    ROUND(
        100.0 * SUM(CASE WHEN lp.late_payment_flag = 1 THEN 1 ELSE 0 END)
        / COUNT(lp.payment_id),
        2
    ) AS late_payment_rate_pct
FROM loan_payments lp
JOIN loans l
    ON lp.loan_id = l.loan_id
GROUP BY l.loan_type
ORDER BY total_amount_paid DESC;


# Late payment analysis
SELECT
    late_payment_flag,
    COUNT(*) AS payment_count,
    SUM(amount_paid) AS total_amount_paid,
    SUM(principal_component) AS principal_paid,
    SUM(interest_component) AS interest_paid,
    ROUND(AVG(amount_paid), 2) AS avg_payment
FROM loan_payments
GROUP BY late_payment_flag
ORDER BY late_payment_flag DESC;


# Monthly Loan Payment Trend
SELECT
    DATE_FORMAT(payment_date, '%Y-%m') AS month,
    COUNT(*) AS payment_count,
    SUM(amount_paid) AS total_amount_paid,
    SUM(principal_component) AS principal_paid,
    SUM(interest_component) AS interest_paid,
    SUM(CASE WHEN late_payment_flag = 1 THEN 1 ELSE 0 END) AS late_payments,
    ROUND(
        100.0 * SUM(CASE WHEN late_payment_flag = 1 THEN 1 ELSE 0 END)
        / COUNT(*),
        2
    ) AS late_payment_rate_pct
FROM loan_payments
GROUP BY DATE_FORMAT(payment_date, '%Y-%m')
ORDER BY month;


# Loan Type + Late Payment Risk
SELECT
    l.loan_type,
    COUNT(lp.payment_id) AS total_payments,
    SUM(CASE WHEN lp.late_payment_flag = 1 THEN 1 ELSE 0 END) AS late_payments,
    ROUND(
        100.0 * SUM(CASE WHEN lp.late_payment_flag = 1 THEN 1 ELSE 0 END)
        / COUNT(lp.payment_id),
        2
    ) AS late_payment_rate_pct,
    SUM(
        CASE
            WHEN lp.late_payment_flag = 1
            THEN lp.amount_paid
            ELSE 0
        END
    ) AS late_payment_amount
FROM loan_payments lp
JOIN loans l
    ON lp.loan_id = l.loan_id
GROUP BY l.loan_type
ORDER BY late_payment_rate_pct DESC;
