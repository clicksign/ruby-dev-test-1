# frozen_string_literal: true

require 'test_helper'

class DirectoryTest < ActiveSupport::TestCase
  def setup
    user = User.create(name: 'Caio Santos')
    Project.create(name: 'Documents Storage', user_id: user.id)
  end

  test 'valid Directory' do
    directory = Directory.new(name: 'Repositories', project_id: 1)

    assert directory.valid?
  end

  test 'valid sub directory' do
    root_directory = Directory.create(name: 'Repositories', project_id: 1)
    sub_directory = Directory.new(
      name: 'ClicksignFileSystem', parent_directory: root_directory, project_id: 1
    )

    assert sub_directory.valid?
    assert_equal 'Repositories/ClicksignFileSystem', sub_directory.path
  end

  test 'validate presence name' do
    directory = Directory.new

    assert_not directory.valid?
    assert_not_empty directory.errors[:name]
  end

  test 'valid associations' do
    assert have_many(:file_objects)
    assert have_many(:directories)
    assert belong_to(:parent_directory).class_name('Directory')
  end
end
