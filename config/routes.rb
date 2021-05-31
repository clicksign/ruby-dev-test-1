Rails.application.routes.draw do
  default_url_options host: ENV.fetch('CANONICAL_HOST') { 'http://testing.io' }

  concern :api_base do
    resources :directories, except: %i[new edit show] do
      resources :files, only: %i[index create destroy]
    end
  end

  namespace :api do
    namespace :v1 do
      concerns :api_base
    end
  end
end
