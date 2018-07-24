Rails.application.routes.draw do

  root 'welcome#index'

  get '/login', to: 'sessions#new'

  post '/login', to: 'sessions#create'

  get '/dashboard', to: 'dashboard#index'

  get '/trips/dashboard', to: 'trips#dashboard'

  resources :users, only: [:new, :create, :show] do
    resources :orders, only: [:show]
  end

  resources :stations, param: :slug

  resources :conditions, only: [:index, :show]

  resources :trips, only: [:index, :show]

end
