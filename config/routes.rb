Rails.application.routes.draw do
  root to: 'issues#index'

  get '/auth/strava/callback', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  resources 'issues', only: [:index, :new, :create, :show]

  get '/admin/login',  to: 'admin/sessions#new'
  post '/admin/login', to: 'admin/sessions#create'

  namespace :api do
    namespace :v1 do
      resources :issues, only: [:index]
    end
  end
end
