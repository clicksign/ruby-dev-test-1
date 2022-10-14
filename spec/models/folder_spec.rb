require 'rails_helper'

RSpec.describe Folder, type: :model do
  context 'Model' do
    let(:file) do
      fixture_file_upload("image.png", "image/png")
    end
    it 'its valid with valid name' do
      expect(Folder.new(name: 'My folder is cool')).to be_valid
    end

    it 'its not valid without name' do
      expect(Folder.new(name: nil)).to be_invalid
    end

    it 'its not valid with not existing parent' do
      expect(build(:folder, parent_id: 1)).to be_invalid
    end

    it 'its valid with existing parent' do
      parent = create(:folder)
      child = create(:folder, parent_id: parent.id)
      expect(child).to be_valid
      expect(parent.children.size).to be_truthy
      expect(parent.children.first.id).to be_eql(child.id)
    end

    it 'its invalid move to a child folder' do
      parent = create(:folder)
      child = create(:folder, parent_id: parent.id)
      expect(parent.update(parent_id: child.id)).to be_falsey
    end

    it 'its valid move to root' do
      parent = create(:folder)
      child = create(:folder, parent_id: parent.id)
      expect(child.update(parent_id: nil)).to be_truthy
    end

    it 'its valid move to a non-self-child folder' do
      parent = create(:folder)
      parent2 = create(:folder)
      child = create(:folder, parent_id: parent.id)
      expect(parent.update(parent_id: parent2.id)).to be_truthy
    end

    it 'its valid attach file' do
      parent = build(:folder)
      expect(parent.files.attach(file)).to be_truthy
      expect(parent.files.size).to be_eql(1)
    end
  end
end
