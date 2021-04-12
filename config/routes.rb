Rails.application.routes.draw do
  scope 'api/v1', defaults: { format: :json }, module: 'api/v1' do
    resources :directories, except: %i[new edit show] do
      resources :files, only: %i[index create destroy]
    end
  end
end
