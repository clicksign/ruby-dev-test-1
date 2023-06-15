Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  namespace :api do
    namespace :v1 do
      resources :documents, only: %i[show create update destroy]
      resources :directories, only: %i[show create update destroy]
    end
  end
end
