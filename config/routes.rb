Rails.application.routes.draw do
  namespace :v1 do
    root 'directories#index'
    resources :directories
    resources :archives, only: %i(create)
  end
end
