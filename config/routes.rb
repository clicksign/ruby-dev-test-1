Rails.application.routes.draw do
  
  root to: "directories#index"
  resources :directories do 
    resources :file_uploads, only: [:new, :create, :destroy]
    get 'sub-directory/new', to: 'directories#new', as: :new_sub_directory
    get 'sub-directory/create', to: 'directories#create', as: :create_sub_directory
    get 'sub-directory/:sub_directory_id/show', to: 'directories#show', as: :show_sub_directory
    get 'sub-directory/:sub_directory_id/edit', to: 'directories#edit', as: :edit_sub_directory
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end


