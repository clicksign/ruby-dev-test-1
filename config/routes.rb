# frozen_string_literal: true

Rails.application.routes.draw do
  root 'file_uploads#index'
  resources :file_uploads, only: %i[new index create]
end
