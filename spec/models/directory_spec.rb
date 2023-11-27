require 'rails_helper'

RSpec.describe Directory, type: :model do
  it { should belong_to(:parent_directory).optional }
  it { should have_many(:documents).dependent(:destroy) }

  it do
    should have_many(:subdirectories).class_name('Directory')
                                     .with_foreign_key('parent_directory_id')
                                     .dependent(:destroy)
  end

  it { should validate_presence_of :name }
end
