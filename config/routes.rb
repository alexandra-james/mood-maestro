Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"

  # recommendations routes
  resources :recommendations, only: [:new, :create]

  # playlists routes
  resources :playlists, only: [:create, :show, :index, :destroy]
  get '/api/artist/:artist', to: 'recommendations#search_artist'
  get '/api/song/:song', to: 'recommendations#search_song'
  post '/create_playlist/:id', to: 'playlists#export_playlist', as: 'create_spotify_playlist'
  get '/api/playlist/:id', to: 'playlists#find_playlist'

  # spotify callback
  get '/auth/spotify/callback', to: 'playlists#spotify'

  # error pages
  match '/400', to: 'errors#bad_request', via: :all
  match '/404', to: 'errors#not_found', via: :all
  match '/500', to: 'errors#internal_server_error', via: :all
end
