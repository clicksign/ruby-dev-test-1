require 'rails_helper'

RSpec.describe Folder, type: :model do
  it { should validate_presence_of(:name) }
  it { should have_many(:child_folders) }
  it { should belong_to(:parent_folder).optional(true) }
end
