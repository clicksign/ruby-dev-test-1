# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Folder, type: :model do
  context 'validations' do
    it 'is valid with valid attributes' do
      expect(FactoryBot.build(:folder)).to be_valid
    end

    it 'is not valid without a name' do
      expect(FactoryBot.build(:folder, name: nil)).to_not be_valid
    end

    it 'is valid without a parent' do
      expect(FactoryBot.build(:folder, parent: nil)).to be_valid
    end

    it 'is not valid with a parent that is itself' do
      folder = FactoryBot.create(:folder)
      folder.parent = folder

      expect(folder).to_not be_valid
    end

    it 'is valid folder parent' do
      folder = FactoryBot.create(:folder)
      expect(FactoryBot.build(:folder, parent: folder)).to be_valid
    end

    it 'is not valid with a parent is not exists' do
      expect(FactoryBot.build(:folder, parent_id: 0)).to_not be_valid
    end

    it 'is valid withou a parent' do
      folder = FactoryBot.create(:folder)
      folder.parent_id = folder.id

      expect(folder).to_not be_valid
    end

    it 'is not valid with a duplicate name' do
      FactoryBot.create(:folder, name: 'Test')
      expect(FactoryBot.build(:folder, name: 'Test')).to_not be_valid
    end

    it 'is not valid with a duplicate name, regardless of case' do
      FactoryBot.create(:folder, name: 'Test')
      expect(FactoryBot.build(:folder, name: 'test')).to_not be_valid
    end
  end
end
