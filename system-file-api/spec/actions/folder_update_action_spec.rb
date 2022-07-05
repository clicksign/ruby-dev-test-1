# frozen_string_literal: true

require 'rails_helper'

describe FolderUpdateAction, type: :class do
  context 'when folder id not exists' do
    it do
      expect do
        described_class.new.perform(0, attributes_for(:folder))
      end.to raise_error(ActiveRecord::RecordNotFound)
    end
  end

  context 'when folder exists' do
    let(:folder) { create(:folder) }

    context 'when send invalid input' do
      it 'with blank name' do
        result = described_class.new.perform(folder.id, attributes_for(:folder, name: nil))
        expect(result[:errors][:name]).to include("can't be blank")
      end

      it 'with invalid folder_id' do
        result = described_class.new.perform(folder.id, attributes_for(:folder, folder_id: 99))
        expect(result[:errors][:folder_id]).to include('is invalid')
      end
    end

    context 'when send valid input' do
      it 'with new name' do
        expect do
          described_class.new.perform(folder.id, attributes_for(:folder))
          folder.reload
        end.to change(folder, :name)
      end

      it 'with new folder_id' do
        parent_folder = create(:folder)
        expect do
          described_class.new.perform(folder.id, attributes_for(:folder, folder_id: parent_folder.id))
          folder.reload
        end.to change(folder, :folder_id)
      end
    end
  end
end
