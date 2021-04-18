require 'rails_helper'

RSpec.describe Folder, type: :model do
  describe "associations" do
    it { is_expected.to belong_to(:parent_folder).class_name("Folder") }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:name) }
  end
end
