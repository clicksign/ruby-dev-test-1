Rails.application.routes.draw do
  resources :folders, only: %i[create] do
    resources :local_files, only: %i[create]
  end
end
