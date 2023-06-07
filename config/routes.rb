Rails.application.routes.draw do
  get 'playlists/new'
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  get '/auth/spotify/callback', to: 'playlists#export'
  # Defines the root path route ("/")
  # root "articles#index"
end
