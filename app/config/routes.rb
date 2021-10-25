Rails.application.routes.draw do
  resources :users, only: %i[index] do
    resources :contracts, only: %i[index show create]
  end
end
