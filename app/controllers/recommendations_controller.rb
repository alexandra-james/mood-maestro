class RecommendationsController < ApplicationController

  def new

  end

  def create
    artists = params[:artists].split(',')
    songs = params[:songs].split(',')
    genres = params[:genres].split(',')
    limit = params[:limit]
    acousticness = params[:acousticness]
    danceability = params[:danceability]
    energy = params[:energy]
    instrumentalness = params[:instrumentalness]
    liveness = params[:liveness]
    mode = params[:mode]
    popularity = params[:popularity]
    speechiness = params[:speechiness]
    tempo = params[:tempo]
    valence = params[:valence]
    # create recommendations
    recommendations = RSpotify::Recommendations.generate(
      limit: limit,
      seed_artists: artists,
      seed_tracks: songs,
      seed_genres: genres,
      target_acousticness: acousticness,
      target_danceability: danceability,
      target_energy: energy,
      target_instrumentalness: instrumentalness,
      target_liveness: liveness,
      target_mode: mode,
      target_popularity: popularity,
      target_speechiness: speechiness,
      target_tempo: tempo,
      target_valence: valence,
    )
    @playlist = create_playlist # create playlist
    songs_array = create_songs(recommendations) # create songs from recommendations
    create_playlistsongs(@playlist, songs_array) # create playlistsongs using songs
    redirect_to playlist_path(@playlist) # redirect to playlist show page
  end

  def create_playlist
    playlist = Playlist.new
    playlist.name = params[:playlist_name]
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
        song.album_name = track.album.name
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
    artists = params[:artist]
    @result_artist = RSpotify::Artist.search(artists, limit: 5).to_json
    p JSON.parse(@result_artist)
    respond_to do |format|
      format.json { render json: @result_artist }
    end
  end

  def search_song
    songs = params[:song]
    @result_song = RSpotify::Track.search(songs, limit: 5).to_json
    p JSON.parse(@result_song)
    respond_to do |format|
      format.json { render json: @result_song }
    end
  end
end
