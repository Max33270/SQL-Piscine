SELECT Title as AlbumName, Name as TrackName, Milliseconds
FROM `albums`
INNER JOIN tracks ON albums.AlbumId = tracks.AlbumId
ORDER BY Milliseconds ASC