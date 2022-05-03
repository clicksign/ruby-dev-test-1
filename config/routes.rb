Rails.application.routes.draw do
  resources :directories 
  resources :sub_folders
  resources :folders
 root "folders#index"
end
