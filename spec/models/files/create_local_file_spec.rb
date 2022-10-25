require 'rails_helper'

RSpec.describe Files::CreateLocalFile do
  describe '.save' do
    context 'when params are valid' do
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

    context 'when folder not exists' do
      specify do
        folder = create(:folder)
        params = attributes_for(:local_file, folder_id: folder.id)
        folder.destroy

        creator = described_class.new(params:)

        expect do
          creator.save
        end.to raise_error(ActiveRecord::RecordInvalid)
           .and change(LocalFile, :count).by(0)
           .and change(Medium, :count).by(0)
      end
    end

    context 'when file name is nil' do
      specify do
        folder = create(:folder)
        params = attributes_for(:local_file, name: nil, folder_id: folder.id)
        folder.destroy

        creator = described_class.new(params:)

        expect do
          creator.save
        end.to raise_error(ActiveRecord::RecordInvalid)
           .and change(LocalFile, :count).by(0)
           .and change(Medium, :count).by(0)
      end
    end
  end
end
