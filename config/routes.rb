Rails.application.routes.draw do
  root to: 'folders#index'
  resources :folders do
    resources 'document_uploads', only: %i[new create destroy]
  end
end
