# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  it { should validate_presence_of(:name) }

  it 'valid user' do
    user = build(:user)

    expect(user.save).to be_truthy
  end

  it 'not valid user' do
    user = build(:user, password: nil)

    expect(user.save).to be_falsey
  end
end
