Rails.application.routes.draw do
  root 'accounts#index'
  get 'sessions/new'
  resources :stocks
  resources :holdings
  resources :accounts
end
