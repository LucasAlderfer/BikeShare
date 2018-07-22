Rails.application.routes.draw do

  root 'welcome#index'

  get '/login', to: 'sessions#index'

  get '/dashboard', to: 'dashboard#index'

  resources :users, only: [:new, :create]

  resources :stations, param: :slug

  resources :conditions, only: [:index, :show]

end
