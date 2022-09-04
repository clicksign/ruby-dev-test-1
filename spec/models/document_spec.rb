require 'rails_helper'

RSpec.describe Document, type: :model do
  describe 'Validates' do
    it { expect { create(:document) }.to change { Document.all.size }.by(1) }
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:description) }
    it { is_expected.to have_one_attached(:file) }
  end
end
