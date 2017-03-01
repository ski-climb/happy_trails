Rails.application.routes.draw do
  root to: 'issues#index'

  get '/auth/strava/callback', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  resources 'issues', only: [:index, :new, :create, :show, :update, :edit]

  namespace :admin do
    resources :trail_days, only: [:new]
    get '/login', to: 'sessions#new'
    post '/login', to: 'sessions#create'
  end

  namespace :api do
    namespace :v1 do
      resources :issues, only: [:index]
      resources :users, only: [] do
        get '/recent_routes', to: 'recent_routes#index'
      end
    end
  end
end
