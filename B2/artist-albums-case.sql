SELECT artists.Name, COUNT(albums.AlbumId) AS NbAlbums,
CASE
    WHEN COUNT(albums.AlbumId) = 1 THEN 'Unproductive'
    WHEN COUNT(albums.AlbumId) > 1 AND COUNT(albums.AlbumId) < 10 THEN 'Productive'
    WHEN COUNT(albums.AlbumId) >= 10 THEN 'Very Productive'
END AS IsProductive
FROM albums
INNER JOIN artists ON albums.ArtistId = artists.ArtistId
GROUP BY albums.ArtistId
LIMIT 100;