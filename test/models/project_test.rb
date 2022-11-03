# frozen_string_literal: true

require 'test_helper'

class ProjectTest < ActiveSupport::TestCase
  test 'valid Project' do
    user = User.create(name: 'Caio Santos')
    project = Project.new(name: 'Documents Storage', user_id: user.id)

    assert project.valid?
  end

  test 'validate presence name' do
    project = Project.new

    assert_not project.valid?
    assert_not_empty project.errors[:name]
  end

  test 'valid associations' do
    assert have_many(:directories)
    assert belong_to(:user)
  end
end
