Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      resources :attach_files
      resources :folders do
        get :sub_folders, on: :member
      end
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
