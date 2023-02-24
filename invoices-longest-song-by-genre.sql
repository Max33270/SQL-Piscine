SELECT DISTINCT invoice.InvoiceId
FROM invoices as invoice 
JOIN invoice_items AS invoice_item ON invoice.InvoiceId = invoice_item.InvoiceId
JOIN tracks AS track ON invoice_item.TrackId = track.TrackId
JOIN genres AS genre ON track.GenreId = genre.GenreId
WHERE track.Milliseconds = (
    SELECT MAX(tracks.Milliseconds)
    FROM tracks
  	WHERE GenreId = genre.GenreId
)
ORDER BY invoice.InvoiceId ASC;