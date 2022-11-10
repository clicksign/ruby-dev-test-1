# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Directory, type: :model do
  describe 'validations' do
    it 'should return invalid if name not present' do
      expect(Directory.new(name: nil)).to be_invalid
    end

    it 'should return invalid if name is not unique' do
      Directory.create(name: 'test')
      expect(Directory.new(name: 'test')).to be_invalid
    end

    it 'should return valid if name is unique' do
      expect(Directory.new(name: 'test')).to be_valid
    end

    it 'should return valid if name is unique and parent is present' do
      parent = Directory.create(name: 'test')
      expect(Directory.new(name: 'test', parent:)).to be_valid
    end

    it 'should return invalid if name is not unique and parent is present' do
      parent = Directory.create(name: 'test')
      Directory.create(name: 'test', parent:)
      expect(Directory.new(name: 'test', parent:)).to be_invalid
    end

    it 'should return invalid if name is not unique and parent is not present' do
      Directory.create(name: 'test')
      expect(Directory.new(name: 'test')).to be_invalid
    end
  end

  describe 'associations' do
    it { is_expected.to belong_to(:parent).class_name('Directory').optional }
    it { is_expected.to have_many(:subdirectories).class_name('Directory').with_foreign_key('parent_id').dependent(:destroy) }
    it { is_expected.to have_many(:files).dependent(:destroy) }
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_uniqueness_of(:name).scoped_to(:parent_id) }

    # it 'should return subdirectories' do
    #   parent = Directory.create(name: 'test')
    #   subdirectory = Directory.create(name: 'test', parent:)
    #   expect(parent.subdirectories).to eq([subdirectory])
    # end

    # it 'should return files' do
    #   directory = Directory.create(name: 'test')
    #   file = File.new(name: 'test', directory:)
    #   expect(directory.files).to eq([file])
    # end
  end
end
