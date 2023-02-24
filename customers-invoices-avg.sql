SELECT FirstName, LastName, AVG(Total) as InvoicesAverage
FROM customers
INNER JOIN invoices WHERE customers.CustomerId = invoices.CustomerId
GROUP BY customers.CustomerId
ORDER BY customers.FirstName ASC