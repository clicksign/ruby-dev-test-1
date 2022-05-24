Rails.application.routes.draw do
  get 'app_files/create'

  resources :folders, only: [:index, :create, :destroy]
  resources :app_files, only: [:create, :destroy]

  root 'folders#index'
end
