WITH address_age_stats AS (
    SELECT
        address,
        MAX(age) AS max_age,
        MIN(age) AS min_age,
        AVG(age) AS avg_age
    FROM
        person
    GROUP BY
        address
),
age_comparison AS (
    SELECT
        address,
        max_age,
        min_age,
        avg_age,
        CAST(max_age AS numeric)-ROUND(CAST(max_age AS numeric) / CAST(min_age AS numeric), 2) AS formula,
        CASE WHEN CAST(max_age AS numeric)-ROUND(CAST(max_age AS numeric) / CAST(min_age AS numeric), 2) > avg_age THEN 'true' ELSE 'false' END AS comparison
    FROM
        address_age_stats
)
SELECT
    address,
    formula,
    round(avg_age,2) AS average,
    comparison
FROM
    age_comparison
ORDER BY
    address;
