Rails.application.routes.draw do
  root 'sessions#new'

  get 'login', to: 'sessions#new'
  get 'signup', to: 'accounts#new'
  get 'logout', to: 'sessions#destroy'

  resources :accounts
  
  resources :stocks do
    resources :holdings
  end

  resources :holdings


end
