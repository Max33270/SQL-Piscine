SELECT DISTINCT tracks.Name as TrackName, playlists.Name as PlaylistName
FROM `playlist_track`
INNER JOIN tracks ON playlist_track.TrackId = tracks.TrackId 
INNER JOIN playlists ON playlist_track.PlaylistId = playlists.PlaylistId 
where playlists.Name = 'TV Shows'
LIMIT 100;