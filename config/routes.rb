Rails.application.routes.draw do

  resources :conditions, only: [:index, :show]

end
