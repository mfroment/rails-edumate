Rails.application.routes.draw do
  devise_for :users
  get 'users/:id', to: 'users#show'
  get 'lessons/:id', to: 'lessons#show'
  get 'lessons/', to: 'lessons#index'
  root to: 'pages#home'
end


