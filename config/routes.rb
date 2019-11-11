Rails.application.routes.draw do
  devise_for :users
  resources :users, only: [:show]
  resources :booking, only: [:create]
  resources :lessons, only: [:show, :index]
  root to: 'pages#home'
end


