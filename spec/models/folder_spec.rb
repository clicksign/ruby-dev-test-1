require 'rails_helper'

RSpec.describe Folder, type: :model do
  describe 'attachments' do
    it { is_expected.to have_many_attached(:files) }
  end

  describe 'associations' do
    it { is_expected.to belong_to(:folder).optional }
    it do
       is_expected.to have_many(:childrens).class_name('Folder')
                                         .with_primary_key(:id)
                                         .with_foreign_key(:folder_id)
    end
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:description) }
  end
  
end
