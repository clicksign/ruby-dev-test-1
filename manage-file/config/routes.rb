Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
  	  namespace :v1 do
        namespace :directory do
          get :list, action: :list
          post :create, action: :create
          delete :destroy, action: :destroy
          get :search, action: :search          
        end
        namespace :the_file do
          get :search, action: :search
        end
  	  end
  end
end
