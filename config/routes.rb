Rails.application.routes.draw do

  resources :folders, only: [:index]

  root 'folders#index'
end
