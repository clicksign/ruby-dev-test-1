Rails.application.routes.draw do
  post '/presigned_url', to: 'direct_upload#create'
end
