Rails.application.routes.draw do

  root 'welcome#index'

  get '/login', to: 'sessions#new'

  post '/login', to: 'sessions#create'
  delete '/logout' => 'sessions#destroy'

  get '/dashboard', to: 'dashboard#index'

  get '/trips-dashboard', to: 'trips#dashboard'


  get '/stations-dashboard', to: 'stations#dashboard'

  get '/bike-shop', to: 'accessories#index'

  get '/cart', to: 'carts#index'

  delete '/cart', to: 'carts#destroy'

  patch '/cart', to: 'carts#update'


  resources :users, only: [:new, :create, :show, :update, :edit] do

    resources :orders, only: [:show]
  end

  resources :stations, param: :slug

  resources :conditions, only: [:index, :show]

  get '/conditions-dashboard', to: 'conditions#dashboard'

  resources :trips, only: [:index, :show]

  resources :carts, only: [:create]

  resources :accessories, only: [:index, :show]

  namespace :admin do
    get '/dashboard', to: 'dashboard#index'
  end
end
