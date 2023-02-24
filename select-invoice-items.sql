SELECT DISTINCT InvoiceId, Name as InvoiceItem, tracks.UnitPrice 
FROM invoice_items
INNER JOIN tracks ON invoice_items.TrackId = tracks.TrackId
WHERE InvoiceId = 10
ORDER BY InvoiceItem ASC;