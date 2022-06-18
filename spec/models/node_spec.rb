require 'rails_helper'

RSpec.describe Node, type: :model do
  it "is valid with valid attributes" do
    expect(Node.new(name: 'Foo')).to be_valid
  end

  it "cannot create another node with same name on root" do
    Node.create!(name: 'Same name')
    node = Node.create(name: 'Same name')
    expect(node.errors.any?).to be_truthy
  end

  it "Can create another node with same name with root parent" do
    root = Node.create!(name: 'Same name')
    node = Node.create(name: 'Same name', parent_id: root.id)
    expect(node.errors.any?).to be_falsey
  end
end
