SELECT EmployeeId, LastName, FirstName, strftime('%d/%m/%Y', HireDate) as HireFrenchDate
FROM employees
ORDER BY HireDate ASC