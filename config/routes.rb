# frozen_string_literal: true

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  namespace :api do
    resources :files, only: %i[create index show]
    resources :folders, only: %i[create index show]
  end
end
