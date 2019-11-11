Rails.application.routes.draw do
  devise_for :users
  get 'users/:id', to: 'users#show'
  get 'lessons/:id', to: 'lessons#show'
  get 'lessons/', to: 'lessons#index'
  post 'bookings/', to: 'bookings#create'
  root to: 'pages#home'
end


