SELECT 
    p.PlaylistId,
    p.Name,
    CASE WHEN COUNT(DISTINCT ii.TrackId) = 0 THEN 0 ELSE ROUND(COUNT(DISTINCT ii.TrackId)*100.0/COUNT(DISTINCT pt.TrackId),4) END AS '% song selled twice'
FROM playlists p
LEFT JOIN playlist_track pt ON p.PlaylistId = pt.PlaylistId
LEFT JOIN invoice_items ii ON pt.TrackId = ii.TrackId AND ii.TrackId IN (SELECT TrackId FROM invoice_items GROUP BY TrackId HAVING COUNT(TrackId) >= 2)
GROUP BY p.PlaylistId
ORDER BY p.PlaylistId ASC;