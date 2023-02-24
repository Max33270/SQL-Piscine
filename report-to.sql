SELECT employees.EmployeeId, employees.FirstName || ' ' || employees.LastName AS EmployeeName, managers.FirstName || ' ' || managers.LastName AS ReportsTo
FROM employees
LEFT JOIN employees managers ON employees.ReportsTo = managers.EmployeeId
ORDER BY employees.EmployeeId;
