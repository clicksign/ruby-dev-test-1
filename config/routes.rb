Rails.application.routes.draw do
  all_routes = lambda do
    root controller: :status, action: :index

    resources :folders
  end

  namespace :api do
    namespace :v1 do
      all_routes.call
    end
  end
end
