require 'rails_helper'

RSpec.describe Files::CreateLocalFile do
  context 'when params are valid' do
    describe '.save' do
      specify do
        folder = create(:folder)
        params = attributes_for(:local_file, folder_id: folder.id)

        creator = described_class.new(params:)

        expect do
          creator.save
        end.to change(LocalFile, :count).by(1)
           .and change(Medium, :count).by(1)
      end
    end
  end
end
