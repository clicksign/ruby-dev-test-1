Rails.application.routes.draw do
  root to: 'home#index'
  resources :directories
  resources :archives
end
