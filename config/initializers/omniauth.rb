Rails.application.config.middleware.use OmniAuth::Builder do
  provider :strava, ENV['CLIENT_ID'].to_i, ENV['CLIENT_SECRET'], scope: 'public'
end