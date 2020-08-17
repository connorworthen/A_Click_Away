Rails.application.routes.draw do
  
  root to: 'main#home'

  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create' 
  get '/login', to: 'sessions#login'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'

  get 'users/:id/products' => 'products#index', :as => :user_products_path
  get 'users/:id/manufacturers' => 'manufacturers#index', :as => :user_manufacturers_path
  get '/search' => 'search#search', :as => :search_page

  get '/auth/twitter/callback' => 'sessions#omniauth'

  resource :products
  resource :manufacturers
  resource :reviews
  resource :users

  resources :manufacturers, only: [:show, :search, :new, :create, :update, :destroy] do
    resources :products, only: [:new, :create]
  end

  resources :users do
    resources :products
  end

  resources :users do
    resources :manufacturers
  end

  resources :products, only: [:new, :create, :show, :edit, :update] do 
    resources :reviews, only: [:new, :create, :show, :destroy]
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
