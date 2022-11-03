# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'valid User' do
    user = User.new(name: 'Caio Santos')

    assert user.valid?
  end

  test 'validate presence name' do
    user = User.new

    assert_not user.valid?
    assert_not_empty user.errors[:name]
  end

  test 'valid associations' do
    assert have_many(:projects)
  end
end
