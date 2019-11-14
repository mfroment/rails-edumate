Rails.application.routes.draw do
  devise_for :users
  resources :users, only: [:show] do
    resources :lessons, only: [:new, :create]
  end
  resources :lessons, only: [:show, :index] do
    resources :bookings, only: [:create]
  end
  root to: 'pages#home'
end


