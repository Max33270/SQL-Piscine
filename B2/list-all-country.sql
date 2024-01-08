SELECT countries.Country, COUNT(*) AS 'Total'
FROM (
    SELECT Country FROM employees
    UNION ALL 
    SELECT Country FROM customers
    UNION ALL
    SELECT BillingCountry AS Country FROM invoices
) AS countries
GROUP BY Country
ORDER BY Country ASC;
