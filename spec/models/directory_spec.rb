require 'rails_helper'

RSpec.describe Directory, type: :model do
  context "with a clean slate" do
    it "accepts an initial orphaned record" do
      node = FactoryBot.build_stubbed(:directory)
      expect(node).to be_valid
    end
    it "refuses nameless records" do
      node = FactoryBot.build_stubbed(:directory, name: nil)
      expect(node).not_to be_valid
    end
    it "refuses a second orphan record" do
      og_root = FactoryBot.build(:directory)
      expect(og_root).to be_valid
      og_root.save
      bad_root = FactoryBot.build_stubbed(:directory)
      expect(bad_root).not_to be_valid
    end
  end
  context "with a populated tree" do
    let!(:root) { FactoryBot.create(:directory) }
    let!(:child_1) { FactoryBot.create(:directory, parent: root) }
    let!(:child_2) { FactoryBot.create(:directory, parent: root) }
    let!(:grandchild_1) { FactoryBot.create(:directory, parent: child_2) }
    let!(:grandchild_2) { FactoryBot.create(:directory, parent: child_2) }
    let!(:great_grandchild_1) { FactoryBot.create(:directory, parent: grandchild_2) }
    let!(:great_grandchild_2) { FactoryBot.create(:directory, parent: grandchild_2) }
    it "returns a node's children" do
      expect(root.children).to include(child_1, child_2)
    end
    it "updates a node's children when we move them around" do
      grandchild_2.parent = root
      expect(root.children).to include(great_grandchild_1, great_grandchild_2)
    end
  end
end
