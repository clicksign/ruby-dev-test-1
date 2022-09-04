require 'rails_helper'

RSpec.describe User, type: :model do
  context 'Validates' do
    it { expect { create(:user) }.to change { User.all.size }.by(1) }
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_presence_of(:password) }
  end
end
