# frozen_string_literal: true

Rails.application.routes.draw do
  get 'file_uploads/index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'file_uploads#index'
  get 'file_uploads/index'
  post 'file_uploads/upload_arquivo'
  post 'file_uploads/download_arquivo'
end
