# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'folders#index'
  resources :folders
  resources :archives
end
