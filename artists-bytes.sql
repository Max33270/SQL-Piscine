SELECT artists.Name AS ArtistName, albums.Title AS AlbumName, tracks.Name AS TrackName, ROUND((tracks.Bytes / 1000000.0),2) ||' MB'  AS MegaBytes
FROM tracks
INNER JOIN albums ON albums.AlbumId = 89
INNER JOIN artists ON artists.ArtistId = albums.ArtistId
WHERE tracks.AlbumId = 89