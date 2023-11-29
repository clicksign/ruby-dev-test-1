# frozen_string_literal: true

require 'api_constraints'

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  scope module: :v1, constraints: ApiConstraints.new(version: 1, default: false) do
    resources :folders, path: 'folders', only: %i[index new create edit update show destroy],
                        path_names: { new: 'new', edit: 'edit' }, param: :folder_id do
      member do
        resources :documents, path: 'documents', only: %i[index new create edit update show destroy],
                              path_names: { new: 'new', edit: 'edit' }, param: :document_id
      end
    end
  end
end
