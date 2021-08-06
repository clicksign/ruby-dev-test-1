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
    it "refuses a node with an invalid parent" do
      expect { FactoryBot.create(:directory, parent_id: -10) }.to raise_exception(ActiveRecord::RecordNotFound)
    end
    it "refuses a second orphan record" do
      og_root = FactoryBot.build(:directory)
      expect(og_root).to be_valid
      og_root.save
      bad_root = FactoryBot.build_stubbed(:directory)
      expect(bad_root).not_to be_valid
    end
    it "refuses an attempt to update both name and parent in one go" do
      node = FactoryBot.create(:directory)
      node2 = FactoryBot.create(:directory, parent: node)
      node3 = FactoryBot.create(:directory, parent: node2)
      expect { node3.update(name: 'its a me', parent: node) }.to throw_symbol(:abort)
    end
    it "allows us to update root's name" do
      node = FactoryBot.create(:directory, name: 'foo')
      node.update!(name: 'bar')
      expect(node.name).to eq('bar')
    end
  end
  context "with a populated tree" do
    let!(:root) { FactoryBot.create(:directory, name: 'root') }
    let!(:child_1) { FactoryBot.create(:directory, name: 'child1', parent: root) }
    let!(:child_2) { FactoryBot.create(:directory, name: 'child2', parent: root) }
    let!(:grandchild_1) { FactoryBot.create(:directory, name: 'grandchild1', parent: child_2) }
    let!(:grandchild_2) { FactoryBot.create(:directory, name: 'grandchild2', parent: child_2) }
    let!(:great_grandchild_1) { FactoryBot.create(:directory, name: 'great_grandchild1', parent: grandchild_2) }
    let!(:great_grandchild_2) { FactoryBot.create(:directory, name: 'great_grandchild2', parent: grandchild_2) }
    it "returns a node's children" do
      expect(root.children).to include(child_1, child_2)
    end
    it "updates a node's children when we move them around" do
      grandchild_2.update!(parent: root)
      expect(root.children).to include(grandchild_2)
      expect(child_2.children).not_to include(grandchild_2)
    end
    it "shows us the names of ancestors separated by /" do
      expect(great_grandchild_2.name_ancestors(and_self: true)).to eq('root/child2/grandchild2/great_grandchild2')
      expect(great_grandchild_1.name_ancestors).to eq('root/child2/grandchild2')
    end
    it "destroys nodes of deleted nodes" do
      expect(root.descendants).to include(great_grandchild_1, great_grandchild_2)
      grandchild_2.destroy
      expect(root.descendants).not_to include(great_grandchild_1, great_grandchild_2)
      expect(Directory.count).to eq(4)
    end
  end
  context "with name already taken" do
    let!(:root) { FactoryBot.create(:directory, name: 'root') }
    let!(:child_1) { FactoryBot.create(:directory, name: 'child1', parent: root) }
    it "renames a conflicting newly created node to name(2)" do
      child_11 = FactoryBot.create(:directory, name: 'child1', parent: root)
      expect(child_11.name).to eq('child1(2)')
    end
    it "renames a conflicting moved node to name(2)" do
      child_11 = FactoryBot.create(:directory, name: 'child1', parent: child_1)
      expect(root.children.where(name: 'child1').count).to eq(1)
      child_11.update!(parent: root)
      expect(root.children.where(name: 'child1').count).to eq(1)
      expect(root.children.where(name: 'child1(2)').count).to eq(1)
    end
  end
  context "when dealing with attachments" do
    let(:root) { FactoryBot.create(:directory) }
    it "correctly deals with single attached file" do
      expect(root.files.attached?).to be_falsey
      root.files.attach(io: File.open('spec/fixtures/files/test.txt'), filename: 'test_file')
      expect(root.files.attached?).to be_truthy
    end
  end
end
