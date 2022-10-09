# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :directories, only: %i[index create] do
    resources :arquives, only: %i[index]
  end

  resources :arquives, only: %i[create] do
    get :file, on: :member
  end
end
