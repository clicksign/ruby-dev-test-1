Rails.application.routes.draw do
  namespace :api do 
    namespace :v1 do 
      resources :folders do
        post "/files", to: "/api/v1/folders#upload_files"
      end
    end
  end
end
