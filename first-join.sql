SELECT Title AS AlbumName, Name AS ArtistName
FROM `artists`
JOIN albums ON artists.ArtistId = albums.ArtistId
LIMIT 100
