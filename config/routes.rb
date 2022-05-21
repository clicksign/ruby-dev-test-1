Rails.application.routes.draw do
  resources :directories, path: "diretorios" do
    member do
      post :edit
    end
  end
  post 'directories/new' => 'directories#new', as: :new_form_directory
  resources :archives, path: "arquivos"
  root "directories#index"
end
