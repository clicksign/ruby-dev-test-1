require 'rails_helper'

RSpec.describe DocumentsController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: 'folders/1/documents').to route_to('documents#index', folder_id: '1')
    end

    it 'routes to #show' do
      expect(get: 'folders/1/documents/1').to route_to('documents#show', id: '1', folder_id: '1')
    end


    it 'routes to #create' do
      expect(post: 'folders/1/documents').to route_to('documents#create', folder_id: '1')
    end

    it 'routes to #update via PUT' do
      expect(put: 'folders/1/documents/1').to route_to('documents#update', id: '1', folder_id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: 'folders/1/documents/1').to route_to('documents#update', id: '1', folder_id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: 'folders/1/documents/1').to route_to('documents#destroy', id: '1', folder_id: '1')
    end
  end
end
