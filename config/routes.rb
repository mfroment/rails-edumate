Rails.application.routes.draw do
  devise_for :users
  resources :users, only: [:show, :edit, :update] do
    resources :lessons, only: [:new, :create]
  end
  resources :lessons, only: [:show, :index, :edit, :update] do
    resources :bookings, only: [:create]
  end
  root to: 'pages#home'
end
