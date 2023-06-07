class RecommendationsController < ApplicationController
  GENRES = {}

  def new

  end

  def create
    artists = params[:artists]
    songs = params[:songs]
    genres = params[:genres]
    limit = params[:limit]
    recommendations = RSpotify::Recommendations.generate(limit: "#{limit}", seed_artists: ["#{artists}"], seed_tracks: ["#{songs}"], seed_genres: ["#{genres}"])
    raise
  end

  def search_artist
    artists = params[:artist]
    @result = RSpotify::Artist.search(artists, limit: 5).to_json
    respond_to do |format|
      format.json { render json: @result }
    end
  end

  def search_song
  end

  def search_genre
  end
end
