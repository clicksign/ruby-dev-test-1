Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :directories do
        resources :archives, except: :index
      end
    end
  end
end
