SELECT Name
From artists
INNER JOIN albums ON artists.ArtistId = albums.ArtistId
GROUP BY Name
HAVING COUNT(albums.ArtistId) > 3 
ORDER BY Name DESC