# frozen_string_literal: true

require 'rails_helper'

RSpec.describe FolderFile, type: :model do
  describe 'validations' do
    it 'should belong to a folder' do
      folder_file = FactoryBot.create(:folder_file)

      expect(folder_file.folder).to be_valid
    end

    it 'is valid withou a folder' do
      folder_file = FactoryBot.build(:folder_file, folder: nil)

      expect(folder_file).to be_valid
    end
  end
end
