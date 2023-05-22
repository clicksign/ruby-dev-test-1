require 'rails_helper'

RSpec.describe Folder, type: :model do
  before do
    @folder_parent = subject.class.create(name: 'Folder Parent')
    @sub_folder = subject.class.create(name: 'Sub Folder', parent_id: @folder_parent.id)
    @folder = subject.class.new(name: 'Folder 1')
  end
  context 'invalid params' do
    it 'name is nil' do
      @folder.name = nil
      expect(@folder).to_not be_valid
    end
    it 'parent_id and name not unique' do
      @folder.parent_id = @folder_parent.id
      @folder.name = 'Sub Folder'
      expect(@folder).to_not be_valid
    end
  end
  context 'valid Player' do
    it { expect(@folder).to be_valid }
  end
  context 'create sub folder' do
    it 'sub folder' do
      @folder.parent_id = @folder_parent.id
      expect(@folder).to be_valid
    end
  end
end
