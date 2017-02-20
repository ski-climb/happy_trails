Rails.application.routes.draw do
  root to: "home#home"
  resources 'issues', only: [:new, :create]
end
