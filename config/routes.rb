# frozen_string_literal: true

Rails.application.routes.draw do
  resources :folders do
    resources :documents
  end

  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'
end
