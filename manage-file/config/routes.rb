Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
		namespace :v1 do
			namespace :directory do
				get :tree, action: :tree				
				get :search, action: :search          
			end
			namespace :the_file do
				get :search, action: :search
			end
			namespace :manage do
				post :upload, action: :upload_file
			end
		end
  end
end
