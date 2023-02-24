SELECT genres.Name, COUNT(tracks.GenreId) as NumberOfTracks
FROM genres
INNER JOIN tracks ON genres.GenreId = tracks.GenreId
GROUP BY genres.Name