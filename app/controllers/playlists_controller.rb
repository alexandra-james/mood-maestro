class PlaylistsController < ApplicationController
  def show
    # show playlist on results page
    @playlist = Playlist.find(params[:id])
  end

  def index
    @playlists = Playlist.where(user_id: current_user)
    @playlist_duration = 0
    @playlists.each do |playlist|
      playlist.songs.each do |song|
        duration = song.duration_ms.fdiv(60_000.0).round
        @playlist_duration += duration
      end
    end
    return @playlist_duration
  end

  def spotify
    session[:spotify_user] = RSpotify::User.new(request.env['omniauth.auth'])
    redirect_to root_path, notice: 'Spotify login successful'
    # setting the user_id and image_url unnecessary as the information can be retrieved from the session
    # current_user.spotify_user_id = session[:spotify_user].id
    # current_user.spotify_image_url = session[:spotify_user].images.first.url
  end

  def export_playlist
    user_playlist = Playlist.find(params[:id])
    # create new playlist on Spotify
    # spotify_user = RSpotify::User.new(request.env['omniauth.auth'])
    @playlist = RSpotify::User.new(session[:spotify_user]).create_playlist!(user_playlist.name)
    # add tracks to playlist
    @song_ids = get_song_ids(user_playlist) #array of song ids to add to playlist
    @playlist.add_tracks!(@song_ids)
    redirect_to "https://open.spotify.com/playlist/#{@playlist.id}", allow_other_host: true

    # set the playlist spotify id for the playlist object
  end

  def get_song_ids(playlist)
    @id_array = []
    playlist.playlist_songs.each do |playlistsong|
      song = Song.find(playlistsong.song_id)
      spotify_id = song.spotify_track_id
      track = RSpotify::Track.find(spotify_id)
      @id_array << track
    end
    return @id_array
  end

  def find_playlist
    # method to get playlist details to show in the dashboard
    @playlist = Playlist.find(params[:id])

    respond_to do |format|
      format.text {render partial: 'details', locals: {playlist: @playlist}, formats: [:html]}
    end
  end

  def destroy
    # delete playlist in the dashboard
    @playlist = Playlist.find(params[:id])
    @playlist.destroy
    redirect_to playlists_path, status: :see_other
  end
end
