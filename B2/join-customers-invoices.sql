SELECT FirstName, LastName, Company, Total as InvoiceTotalPrice
FROM `customers`
INNER JOIN invoices ON customers.CustomerId = invoices.CustomerId
WHERE Company NOT NULL;