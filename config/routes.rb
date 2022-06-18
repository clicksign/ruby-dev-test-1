Rails.application.routes.draw do

  namespace :api do
    resources :assets, only: [:create, :show, :destroy]
    resources :nodes
  end
  
  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
