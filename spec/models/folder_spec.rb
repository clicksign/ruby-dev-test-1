require 'rails_helper'

RSpec.describe Folder, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:parent).optional(true) }
    it { is_expected.to have_many(:sub_folders) }
    it { is_expected.to have_many(:attach_files).dependent(:destroy) }
  end
end
