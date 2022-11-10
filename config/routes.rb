Rails.application.routes.draw do
  get '/uploads', to: 'upload#index'
  post '/uploads', to: 'upload#create'
end
