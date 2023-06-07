class PlaylistsController < ApplicationController
  def show
  end

  def new
  end

  def create
  end

  def result
  end

  def export
    spotify_user = RSpotify::User.new(request.env['omniauth.auth'])

    spotify_user.create_playlist!('my-awesome-playlist')
  end

  def destroy
  end
end
