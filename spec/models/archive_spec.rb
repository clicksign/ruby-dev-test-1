require 'rails_helper'

RSpec.describe Archive, :type => :model do

  describe 'associations' do
    it { should belong_to(:created_by).class_name('User') }
    it { should belong_to(:directory) }
  end

  describe 'validations' do
    it { should validate_presence_of(:filename) }
    it { should validate_presence_of(:created_by_id) }
    it { should validate_presence_of(:directory_id) }
  end
end