class RecommendationsController < ApplicationController

  def new
  end

  def create
    artists = params[:artists].split(',')
    songs = params[:songs].split(',')
    genres = params[:genres]
    limit = params[:limit]

    recommendations = RSpotify::Recommendations.generate(
      limit: limit,
      seed_artists: artists,
      seed_tracks: songs,
      seed_genres: genres
    )
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
