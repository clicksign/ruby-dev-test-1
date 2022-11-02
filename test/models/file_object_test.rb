# frozen_string_literal: true

require 'test_helper'

class FileObjectTest < ActiveSupport::TestCase
  test 'valid FileObject' do
    directory = Directory.create(name: 'Projects')
    file = FileObject.new(
      name: 'ClicksignFileSystem.txt', path: '/Projects', directory: directory
    )

    assert file.valid?
  end

  test 'invalid file without directory' do
    file = FileObject.new(name: 'ClicksignFileSystem.txt', path: '/')

    assert_not file.valid?
  end

  test 'validate presence name' do
    file = FileObject.new

    assert_not file.valid?
    assert_not_empty file.errors[:name]
  end

  test 'valid associations' do
    assert belong_to(:directory)
  end
end
