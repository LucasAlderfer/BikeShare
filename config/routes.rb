Rails.application.routes.draw do

  root 'welcome#index'

  get '/login', to: 'sessions#new'

  post '/login', to: 'sessions#create'

  get '/dashboard', to: 'dashboard#index'

  get '/trips/dashboard', to: 'trips#dashboard'


  get '/stations-dashboard', to: 'stations#dashboard'

  get '/bike-shop', to: 'accessories#index'


  resources :users, only: [:new, :create, :show] do

    resources :orders, only: [:show]
  end

  resources :stations, param: :slug

  resources :conditions, only: [:index, :show]

  resources :trips, only: [:index, :show]

  resources :carts, only: [:create]

  resources :accessories, only: [:index]
end
