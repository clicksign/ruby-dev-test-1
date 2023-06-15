require 'rails_helper'

RSpec.describe Document, type: :model do
  describe 'validations' do
    it { should validate_presence_of :name }
  end

  describe 'association' do
    it { should belong_to(:directory) }
  end
end
