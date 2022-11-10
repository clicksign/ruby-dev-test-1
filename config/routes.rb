Rails.application.routes.draw do
  # post '/presigned_url', to: 'direct_upload#create'
  # post '/attachment', to: 'attachment#create'
  get '/uploads', to: 'upload#index'
  post '/uploads', to: 'upload#create'
end
