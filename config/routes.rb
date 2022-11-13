require 'sidekiq/web'
Rails.application.routes.draw do
  resources :uploads

  mount Sidekiq::Web => '/sidekiq'

end
