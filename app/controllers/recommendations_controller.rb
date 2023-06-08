class RecommendationsController < ApplicationController
  GENRES = {}

  def new
  end

  def create
    # create recommendations
    artists = params[:artists]
    songs = params[:songs]
    genres = params[:genres]
    limit = params[:limit]
    recommendations = RSpotify::Recommendations.generate(limit: "#{limit}", seed_artists: ["#{artists}"], seed_tracks: ["#{songs}"], seed_genres: ["#{genres}"])
    @playlist = create_playlist # create playlist
    songs_array = create_songs(recommendations) # create songs from recommendations
    create_playlistsongs(@playlist, songs_array) # create playlistsongs using songs
    redirect_to playlist_path(@playlist) # redirect to playlist show page
  end

  def create_playlist
    playlist = Playlist.new
    playlist.name = "playlist-test" # TODO- input field for name
    playlist.user = current_user
    playlist.save
    return playlist
  end

  def create_songs(recommendations)
    songs = []
    recommendations.tracks.each do |track|
      if Song.find_by(spotify_track_id: track.id)
        songs << Song.find_by(spotify_track_id: track.id)
      else
        song = Song.new
        song.name = track.name
        song.artist_name = track.artists.first.name # when there are more artists the first one is chosen
        song.spotify_track_id = track.id
        song.spotify_image_url = track.album.images.last["url"] # last image is the smallest size of 64x64
        song.duration_ms = track.duration_ms
        song.save
        songs << song
      end
    end
    return songs
  end

  def create_playlistsongs(playlist, songs_array)
    songs_array.each do |song|
      playlist_song = PlaylistSong.new
      playlist_song.song = song
      playlist_song.playlist = playlist
      playlist_song.save
    end
  end

  def search_artist
  end

  def search_song
  end

  def search_genre
  end
end
