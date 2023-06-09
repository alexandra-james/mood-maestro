require 'rspotify/oauth'

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :spotify, ENV["CLIENT_ID"],ENV["CLIENT_SECRET"], scope: ' ugc-image-upload user-read-email playlist-modify-private playlist-modify-public user-library-read user-library-modify'
end

OmniAuth.config.allowed_request_methods = [:post, :get]
OmniAuth.config.silence_get_warning = true

