Rails.application.routes.draw do
  resources :assets, only: [:create, :show, :destroy]
  resources :nodes
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
