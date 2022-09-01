Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  
  api_version(:module => "v1", path: {value: "v1"}) do
    resources :folders do      
      get "/parent", to: "folders#parent"
      get "/sub_folders", to: "folders#sub_folders"      
      resources :uploads
    end
  end  
end
