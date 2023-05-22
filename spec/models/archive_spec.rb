require 'rails_helper'

RSpec.describe Archive, type: :model do
  before do
    @folder = Folder.create(name: 'Folder 1')
    @archive = subject.class.new(folder_id: @folder.id, name: 'Archive 1')
  end
  context 'invalid params' do
    it 'folder_id is nil' do
      @archive.folder_id = nil
      expect(@archive).to_not be_valid
    end
  end
  context 'valid Archive' do
    it { expect(@archive).to be_valid }
  end
end
