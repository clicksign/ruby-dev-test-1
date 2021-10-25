Rails.application.routes.draw do
  resources :archives, only: %i[create show], defaults: { format: :json }
end
