require 'rails_helper'

RSpec.describe Player, type: :model do


  it { is_expected.to validate_presence_of(:name) }

  it { is_expected.to have_and_belong_to_many (:albums) }

  it 'valid player' do
    player = create(:player)
    expect(player).to be_valid
  end

  it 'valid player' do
    player = create(:player)
    expect(player).to be_valid
  end

  it 'presence of name' do
    player = Player.new
    expect(player).not_to be_valid
  end
end
