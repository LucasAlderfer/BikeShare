Rails.application.routes.draw do

  resources :stations, param: :slug

  resources :conditions, only: [:index, :show]

end
