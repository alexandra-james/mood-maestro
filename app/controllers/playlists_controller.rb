class PlaylistsController < ApplicationController
  def show
    # show playlist on results page
    @playlist = Playlist.find(params[:id])
  end

  def index
    @playlists = Playlist.where(user_id: current_user)
  end

  def spotify
    playlist = Playlist.find(params[:id])
    # create new playlist on Spotify
    # spotify_user = RSpotify::User.new(request.env['omniauth.auth'])
    # spotify_user.create_playlist!(@playlist.name)
    # add tracks to playlist
    song_ids = get_song_ids(playlist) #array of song ids to add to playlist
    raise
    playlist.add_tracks!(song_ids)
    playlist.tracks.first.name

    # set the playlist spotify id for the playlist object
  end

  def get_song_ids(playlist)
    id_array = []
    playlist.playlist_songs.each do |playlistsong|
      song = Song.find(playlistsong.song_id)
      spotify_id = song.spotify_track_id
      id_array << spotify_id
    end
    return id_array
  end

  def destroy
    # delete playlist in the dashboard
    @playlist = Playlist.find(params[:id])
    @playlist.destroy
    redirect_to playlists_path, status: :see_other
  end
end
