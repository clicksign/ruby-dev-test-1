Rails.application.routes.draw do
  post '/archives', to: 'archives#create'
  get '/archives/:id', to: 'archives#show'
  get '/directory/:name', to: 'archives#show_directory'
end
