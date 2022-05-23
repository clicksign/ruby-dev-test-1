Rails.application.routes.draw do

  resources :folders, only: [:index, :show]
  root "folders#index"
end
