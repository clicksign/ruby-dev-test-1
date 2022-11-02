# frozen_string_literal: true

require 'test_helper'

class FileObjectTest < ActiveSupport::TestCase
  test 'valid Directory' do
    directory = Directory.new(name: 'Projects')

    assert directory.valid?
  end

  test 'valid sub directory' do
    root_directory = Directory.create(name: 'Projects')
    sub_directory = Directory.new(name: 'ClicksignFileSystem', parent_directory: root_directory)

    assert sub_directory.valid?
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
