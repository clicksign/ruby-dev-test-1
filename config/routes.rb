Rails.application.routes.draw do
  root to: 'directories#index'

  resources :directories, only: [:index, :show, :edit, :update, :destroy]
  resources :image_files, only: [:new, :create, :show, :destroy]

  get 'add_new_directory/:parent_directory_id', to: 'directories#add_new', as: 'add_new_directory'
  delete "directories/:id", to: 'directories#destroy', as: 'directory_destroy'
  
  get 'add_new_image_file/:directory_id', to: 'image_files#add_new', as: 'add_new_image_file'
  delete "image_files/:id", to: 'image_files#destroy', as: 'image_file_destroy'
end
