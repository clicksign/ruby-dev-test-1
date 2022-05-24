require 'rails_helper'

RSpec.describe FoldersHelper, type: :helper do
  describe FoldersHelper do
    describe ".folder_icon" do
      let(:empty_folder) { create :folder }
      let(:filed_folder) { create :folder, :with_file_attached }

      it "should return empty icon file name for empty folders" do
        expect(helper.folder_icon(empty_folder)).to eq("empty-folder.png")
      end

      it "should return folder and files icon name for filled folders" do
        expect(helper.folder_icon(filed_folder)).to eq("files-and-folders.png")
      end
    end
  end
end
