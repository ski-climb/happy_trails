Rails.application.routes.draw do
  root to: 'issues#index'

  resources 'issues', only: [:index, :new, :create]

  get '/auth/strava/callback', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
end
