Rails.application.routes.draw do
  root 'v1/directories#index'
  namespace :v1 do
    resources :directories, only: %i(index create)
    resources :archives, only: %i(create)
  end
end
