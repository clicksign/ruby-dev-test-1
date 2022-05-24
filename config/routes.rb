Rails.application.routes.draw do
  resources :folders do
    resources :children, controller: :folders, only: [:new]
  end

  root "folders#index"
end
