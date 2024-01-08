SELECT Name
FROM tracks
WHERE TrackID = (
    SELECT invoice_items.TrackId
  	FROM invoice_items
  	WHERE invoice_items.InvoiceId = (
      SELECT invoices.InvoiceId
      FROM invoices
      ORDER BY InvoiceDate DESC
 	)
 LIMIT 1
 )