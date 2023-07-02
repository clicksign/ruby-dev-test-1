Rails.application.routes.draw do
  
  devise_for :users, 
    controllers: {
      sessions: 'users/sessions',
      registrations: 'users/registrations'
  }

  index_show_update_create_destroy = %w(index show update create destroy)

  root 'aplication#home'

  scope 'api', module: 'api', as: 'api' do 
    get 'status' => 'api#status', as: 'status'

    scope 'v1', module: 'version_one', as: 'v1' do
      resources 'directories', only: index_show_update_create_destroy do
        member do 
          get 'subdirectories' => 'directories#get_subdirectories'
        end
      end

      resources 'archives', only: index_show_update_create_destroy
    end
  end

end
