Rails.application.routes.draw do
  resources :folders, only: [:index, :show, :new, :create]
  root to: 'folders#index'

  get '/file_upload/new', to: 'folders#new_file'
  post '/file_upload/uploading', to: 'folders#new_file_upload'
end
