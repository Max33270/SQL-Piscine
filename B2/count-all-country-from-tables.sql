SELECT Country, COUNT(*) AS Total,
(SELECT COUNT(*) FROM employees WHERE Country = Country.Country) AS Employees,
(SELECT COUNT(*) FROM customers WHERE Country = Country.Country) AS Customers,
(SELECT COUNT(*) FROM invoices WHERE BillingCountry = Country.Country) AS Invoices
FROM (
    SELECT Country FROM employees
    UNION ALL
    SELECT Country FROM customers
    UNION ALL
    SELECT BillingCountry AS Country FROM invoices
) AS Country
GROUP BY Country
ORDER BY Country ASC;