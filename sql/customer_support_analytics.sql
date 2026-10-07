# overall support performance
SELECT
    COUNT(*) AS total_tickets,
    COUNT(DISTINCT customer_id) AS customers_with_tickets,
    SUM(CASE WHEN status = 'Resolved' THEN 1 ELSE 0 END) AS resolved_tickets,
    SUM(CASE WHEN status = 'Open' THEN 1 ELSE 0 END) AS open_tickets,
    ROUND(
        100.0 * SUM(CASE WHEN status = 'Resolved' THEN 1 ELSE 0 END)
        / COUNT(*),
        2
    ) AS resolution_rate_pct,
    ROUND(AVG(satisfaction_score), 2) AS avg_satisfaction
FROM support_tickets;



#tickets by issue type
SELECT
    issue_type,
    COUNT(*) AS ticket_count,
    SUM(CASE WHEN status = 'Resolved' THEN 1 ELSE 0 END) AS resolved_tickets,
    SUM(CASE WHEN status = 'Open' THEN 1 ELSE 0 END) AS open_tickets,
    ROUND(
        100.0 * SUM(CASE WHEN status = 'Resolved' THEN 1 ELSE 0 END)
        / COUNT(*),
        2
    ) AS resolution_rate_pct,
    ROUND(AVG(satisfaction_score), 2) AS avg_satisfaction
FROM support_tickets
GROUP BY issue_type
ORDER BY ticket_count DESC;



# resolution time analysis
SELECT
    issue_type,
    COUNT(*) AS resolved_tickets,
    ROUND(
        AVG(
            TIMESTAMPDIFF(
                HOUR,
                date_opened,
                date_resolved
            )
        ),
        2
    ) AS avg_resolution_hours,
    ROUND(
        MIN(
            TIMESTAMPDIFF(
                HOUR,
                date_opened,
                date_resolved
            )
        ),
        2
    ) AS min_resolution_hours,
    ROUND(
        MAX(
            TIMESTAMPDIFF(
                HOUR,
                date_opened,
                date_resolved
            )
        ),
        2
    ) AS max_resolution_hours
FROM support_tickets
WHERE date_resolved IS NOT NULL
GROUP BY issue_type
ORDER BY avg_resolution_hours DESC;




#satisfaction analysis
SELECT
    satisfaction_score,
    COUNT(*) AS ticket_count,
    SUM(CASE WHEN status = 'Resolved' THEN 1 ELSE 0 END) AS resolved_tickets,
    ROUND(
        100.0 * SUM(CASE WHEN status = 'Resolved' THEN 1 ELSE 0 END)
        / COUNT(*),
        2
    ) AS resolution_rate_pct
FROM support_tickets
WHERE satisfaction_score IS NOT NULL
GROUP BY satisfaction_score
ORDER BY satisfaction_score;