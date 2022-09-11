require 'rails_helper'

RSpec.describe User, type: :model do
  context 'relationship' do
    it { is_expected.to have_many(:folders) }
  end

  context 'validates' do
    it { expect { create(:user) }.to change { User.all.size }.by(1) }
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_presence_of(:password) }
  end

  describe 'after_commit' do
    it { expect { create(:user) }.to change { Folder.all.size }.by(1) }

    it 'create root folder' do
      user = create(:user)
      expect(user.folders.first.name).to eq('Root')
    end
  end
end
