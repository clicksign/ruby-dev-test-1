# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :folders, expect: [:index] do
    member do
      get :childrens
    end
    resources :file_items
  end
end
