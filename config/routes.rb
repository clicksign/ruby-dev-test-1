Rails.application.routes.draw do
  resources :arquivos, only: [:index, :show, :update, :create]
end
