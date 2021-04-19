require 'rails_helper'

RSpec.describe Folder, type: :model do
  describe "associations" do
    it { is_expected.to belong_to(:parent_folder) }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:name) }

    it "validates if parent folder exists" do
      folder = Folder.new(name: "Child", folder_id: 1000)

      expect(folder.valid?).to be false
    end
  end
end
