Rails.application.routes.draw do
  resources :folders, only: [:index, :show, :new, :create]
  root to: 'folders#index'
end
