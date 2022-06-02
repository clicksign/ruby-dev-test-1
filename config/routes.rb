Rails.application.routes.draw do
  resources :folders
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
	root "folders#index"
	resources :folders do
		resources :files, only: [:new, :create]
	end
end
