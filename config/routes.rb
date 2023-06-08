Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"

  # recommendations routes
  resources :recommendations, only: [:new, :create]

  # playlists routes
  resources :playlists, only: [:create, :show]

  # back from spotify login
  get '/auth/spotify/callback', to: 'playlists#export'
end
