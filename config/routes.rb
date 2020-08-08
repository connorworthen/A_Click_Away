Rails.application.routes.draw do
  
  root to: 'main#home'
 
  resources :manufacturers, only: [:index, :search, :show, :new, :create] do 
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

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end