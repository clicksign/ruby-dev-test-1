Rails.application.routes.draw do
  resources :arquivos, only: [:index, :show, :edit, :create]
end
