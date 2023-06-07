class SongsController < ApplicationController

  def spotify
    tracks = RSpotify::Track.search('Know')
    playlist.add_tracks!(tracks)
    playlist.tracks.first.name
  end
end
