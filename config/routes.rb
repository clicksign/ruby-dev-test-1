Rails.application.routes.draw do
  scope 'api/v1', defaults: { format: :json }, module: 'api/v1' do
    resources :directories, except: %i[new edit show]
  end
end
