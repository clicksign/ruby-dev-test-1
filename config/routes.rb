# frozen_string_literal: true

Rails.application.routes.draw do
  resources :file_uploads, only: %i[new index create]
end
