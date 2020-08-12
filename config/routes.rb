Rails.application.routes.draw do
  
  root to: 'main#home'
 
  resources :manufacturers, only: [:show, :search, :new, :create] do 
    resources :products, only: [:new, :create]
  end 

  resources :products, only: [:new, :create, :show, :edit, :update] do 
    resources :reviews, only: [:new, :create, :show, :edit, :update]
  end

  resources :users, only: [:new, :create, :show]

  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'
  get '/login', to: 'sessions#login'
  post '/login', to: 'sessions#create'

  get '/logout', to: 'sessions#destroy'
  get '/products', to: 'products#show'
  post '/products/new', to: 'products#create'
  get '/manufacturers', to: 'manufacturers#show'
  get '/auth/:provider/callback', to: 'sessions#omniauth'

  get '/products/:id', to: 'products#edit'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end