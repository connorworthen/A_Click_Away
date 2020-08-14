Rails.application.routes.draw do
  
  root to: 'main#home'

  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'
  get '/login', to: 'sessions#login'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'


  resource :products
  resource :manufacturers

  resources :manufacturers, only: [:show, :search, :new, :create] do 
    resources :products, only: [:new, :create]
  end

  resources :users do
    resources :products
  end

  get 'users/:id/products' => 'products#index', :as => :user_products_path

  # get 'products', action: :index, controller: 'index'

  # resources :users, only: [:new, :create, :show]

  # resources :products, only: [:new, :create, :show, :edit, :update] do
  # #   resources :reviews, only: [:new, :create, :show, :edit, :update]
  # # end

  # get '/manufacturers', to: 'manufacturers#show'
  # get '/auth/:provider/callback', to: 'sessions#omniauth'

  # get '/products/:id', to: 'products#edit'
  # get '/products', to: 'products#show'
  # post '/products/new', to: 'products#create'


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end