class PlaylistsController < ApplicationController
  def show
    # show playlist on results page
    @playlist = Playlist.find(params[:id])
  end

  def export
    # create new playlist on Spotify
    spotify_user = RSpotify::User.new(request.env['omniauth.auth'])
    spotify_user.create_playlist!('my-awesome-playlist')

    # set the playlist spotify id for the playlist object
  end

  def destroy
    # delete playlist in the dashboard
  end
end
