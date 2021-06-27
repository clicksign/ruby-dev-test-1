Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :directories do
        resources :subdirectories
      end
    end
  end
end
