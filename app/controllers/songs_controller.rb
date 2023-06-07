class SongsController < ApplicationController

  def spotify
    
    playlist.add_tracks!(tracks)
    playlist.tracks.first.name
  end
end
