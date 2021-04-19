Rails.application.routes.draw do
  resources :folders

  root to: "folders#index"
end
