Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"

  # recommendations routes
  resources :recommendations, only: [:new, :create]

  # playlists routes
  resources :playlists, only: [:create, :show, :index, :destroy]
  get '/api/artist/:artist', to: 'recommendations#search_artist'
  get '/api/song/:song', to: 'recommendations#search_song'
  post '/create_playlist/:id', to: 'playlists#spotify', as: 'create_spotify_playlist'

  # back from spotify login
  get '/auth/spotify/callback', to: 'playlists#export'
end
