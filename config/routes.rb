Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resources :folders, only: [:create, :show, :update, :destroy]
      resources :archives, only: [:create, :show, :update, :destroy]
    end
  end
end
