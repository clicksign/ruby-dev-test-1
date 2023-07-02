require 'rails_helper'

RSpec.describe Directory, :type => :model do

  describe 'associations' do
    it { should belong_to(:created_by).class_name('User') }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:created_by_id) }
  end
end