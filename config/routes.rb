Rails.application.routes.draw do
  resources :folder_files
  resources :folders
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'folders#index'
  get 'home', to: 'home#index'
end
