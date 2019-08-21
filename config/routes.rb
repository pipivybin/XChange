Rails.application.routes.draw do
  root 'sessions#new'

  get '/auth/facebook/callback' => 'sessions#fbcreate'

  get 'login', to: 'sessions#new'
  get 'signup', to: 'accounts#new'
  get 'logout', to: 'sessions#destroy'
  post '/sessions/create', to: 'sessions#create'

  resources :accounts
  
  resources :stocks do
    resources :holdings
  end

  resources :holdings

  

end
