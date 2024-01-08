SELECT invoice.InvoiceId, 
       ROUND(AVG(invoice_item.UnitPrice),2) AS 'Average Price',
       SUM(track.Milliseconds) / 1000 AS 'Track Total Time',
       ROUND(AVG(invoice_item.UnitPrice) / (SUM(track.Milliseconds) / 1000),5) || '€' AS 'Price by second' 
FROM invoices as invoice
JOIN invoice_items AS invoice_item ON invoice.InvoiceId = invoice_item.InvoiceId
JOIN tracks AS track ON invoice_item.TrackId = track.TrackId
GROUP BY invoice.InvoiceId
ORDER BY invoice.InvoiceId ASC;