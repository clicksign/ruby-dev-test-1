Rails.application.routes.draw do
  
  root to: "directories#index"
  resources :directories do 
    resources :file_uploads, only: [:new, :create, :destroy]
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end


