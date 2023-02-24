SELECT employees.LastName  || ' ' ||  employees.FirstName AS '3rd best seller'
FROM employees
INNER JOIN customers ON customers.SupportRepId = employees.EmployeeId
INNER JOIN invoices ON invoices.CustomerId = customers.CustomerId
GROUP BY EmployeeId
ORDER BY SUM(invoices.Total) ASC
Limit 1