Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  resources :folders, except: :new do
    member do
      get :new_folder
    end
    resources :documents, only: %i[new create destroy]
  end

  # Defines the root path route ("/")
  root "folders#index"
end
