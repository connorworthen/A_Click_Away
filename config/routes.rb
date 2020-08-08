Rails.application.routes.draw do
  
  root to: 'main#home'
 
  resources :manufacturers, only: [:index, :search, :show] do 
    resources :products, only: [:new, :create]
  end 

  resources :products, only: [:new, :create, :show, :edit, :update] do 
    resources :reviews, only: [:new, :create, :show, :edit, :update]
  end

  resources :users, only: [:new, :create, :show]

  get '/login', to: 'sessions#login'
  post '/login', to: 'sessions#create'

  get '/logout', to: 'sessions#destroy'

  post '/products/new', to: 'products#create'
  get '/auth/:provider/callback', to: 'sessions#omniauth'
  post '/products/:id/reviews/new', to: 'reviews#create'
  post '/users/:user_id/create_follow', to: 'follows#create', as: 'create_follow'
  post '/users/:user_id/unfollow', to: 'follows#unfollow', as: 'unfollow'

  post '/reviews/:id', to: 'reviews#destroy', as: 'delete_review'

  get '/users/:user_id/following', to: 'follows#following', as: 'user_following'
  get '/users/:user_id/followers', to:  'follows#followers', as: 'user_follower'

  get '/products/index', to: 'products#index'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end