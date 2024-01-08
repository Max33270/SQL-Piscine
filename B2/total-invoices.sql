SELECT FirstName||' '||UPPER(LastName) as FullName, SUM(invoices.Total) as AllInvoices
FROM customers
INNER JOIN invoices ON customers.CustomerId = invoices.CustomerId
GROUP BY FullName
HAVING SUM(invoices.Total) > 38
ORDER BY FullName ASC
