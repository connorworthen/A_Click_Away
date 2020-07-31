Rails.application.routes.draw do
  get 'main/home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'main#home'
  get '/signup', to: 'users#new', as: "new_user"
  post '/signup', to: 'users#create', as: 'users_path'
  get '/login', to: 'sessions#login'
  post '/login', to: 'sessions#create'
  post '/logout', to: 'sessions#destroy'

  resources :users, only: [:new, :create, :show]
end
