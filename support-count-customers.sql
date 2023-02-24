SELECT employees.FirstName||' '||UPPER(employees.LastName) as FullName, COUNT(employees.EmployeeId) as NumberOfCustomers
FROM employees
INNER JOIN customers ON employees.EmployeeId = customers.SupportRepId
WHERE Title = 'Sales Support Agent'
GROUP BY FUllName
ORDER BY NumberOfCustomers ASC
