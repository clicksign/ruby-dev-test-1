require 'rails_helper'

RSpec.describe Folder, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:parent).optional(true) }
    it { is_expected.to have_many(:sub_folders) }
  end
end
