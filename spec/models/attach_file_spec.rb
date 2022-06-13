require 'rails_helper'

RSpec.describe AttachFile, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:folder) }
    it { is_expected.to have_one_attached(:file)}
  end
end
