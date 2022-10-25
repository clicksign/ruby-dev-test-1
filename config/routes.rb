Rails.application.routes.draw do
  resources :folders, only: %i[create]
end
