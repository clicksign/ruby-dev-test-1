Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :directories do
        resources :archives
      end
    end
  end
end
