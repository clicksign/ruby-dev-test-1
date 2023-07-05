Rails.application.routes.draw do
  resources :directories do
    resources :aws_files, only: [:new, :create, :destroy]
  end

  root 'directories#index'
end
