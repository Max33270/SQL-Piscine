SELECT LastName, FirstName,
    COUNT(*) AS 'Total Sell',
    COUNT(*) / (SELECT COUNT(*) FROM invoices) * 100 AS 'Percentage sales compared best seller',
    COUNT(*) / (SELECT COUNT(*) FROM invoices WHERE EmployeeId = 3) AS 'Total Sell By Employee',
    (SELECT Country FROM customers WHERE CustomerId = (SELECT CustomerId FROM invoices WHERE EmployeeId = 3 GROUP BY CustomerId ORDER BY COUNT(*) DESC LIMIT 1)) AS 'Country With Most Sales',
    (SELECT Name FROM genres WHERE GenreId = (SELECT GenreId FROM tracks GROUP BY GenreId ORDER BY COUNT(*) DESC LIMIT 1)) AS 'Most Genre Selled',
    (SELECT Name FROM media_types WHERE MediaTypeId = (SELECT MediaTypeId FROM tracks GROUP BY MediaTypeId ORDER BY COUNT(*) DESC LIMIT 1)) AS 'Most Media Type Selled'
FROM employees
