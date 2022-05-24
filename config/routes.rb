Rails.application.routes.draw do
  get 'app_files/create'

  resources :folders, only: [:index, :create]
  resources :app_files, only: [:create]

  root 'folders#index'
end
