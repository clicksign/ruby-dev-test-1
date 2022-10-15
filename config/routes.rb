Rails.application.routes.draw do
  root "documents#index"
  devise_for :users
  resources :documents
  resources :folders
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
