Rails.application.routes.draw do
  root to: "nodes#show"

  resources :nodes, except: %i[index show]
end
