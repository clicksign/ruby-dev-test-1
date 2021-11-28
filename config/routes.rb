Rails.application.routes.draw do
  root to: 'folders#index'
  resources :folders
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
