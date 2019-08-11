Rails.application.routes.draw do
  root 'accounts#index'
  get 'sessions/new'
  
  get 'login', to: 'sessions#new'
  get 'signup', to: 'accounts#new'
  get 'logout', to: 'sessions#destroy'

  resources :stocks
  resources :holdings
  resources :accounts
end
