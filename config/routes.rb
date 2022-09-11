# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'folders#index'

  # Documents
  resources :documents, only: %i[create update destroy]
  # Folders
  resources :folders
end
