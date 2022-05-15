# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :directories do
        member do
          post :upload_file
        end
      end
    end
  end
end
