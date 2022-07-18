require 'rails_helper'

RSpec.describe FileInfo, type: :model do
  
  describe '.create' do
    let(:file) { FactoryBot.create(:local_file) }

    context "When is FileInfoDatabase" do 
      it "will be store in blob database" do
        file_db = FileInfoDatabase.create(file_system_id: file.id, temp_path: "#{Rails.root}/spec/support/examples/file.ext")
        expect(file_db.file_blob).to be_truthy 
      end
    end

    context "When is FileInfoLocal" do 
      it "will be store in system" do
        file_local = FileInfoLocal.create(file_system_id: file.id, temp_path: "#{Rails.root}/spec/support/examples/file.ext")
        expect(File).to exist("#{Rails.root}/storage/" + file_local.path)
      end
    end

    context "When is FileInfoS3" do 
      it "will be store in amazon S3" do
        file_s3 = FileInfoS3.create(file_system_id: file.id, temp_path: "#{Rails.root}/spec/support/examples/file.ext")
        expect(file_s3.file).to be_attached
      end
    end

  end
end