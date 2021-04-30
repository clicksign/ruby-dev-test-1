require 'rails_helper'

RSpec.describe Document, type: :model do
  it "is not valid without any attributes" do
    document = Document.new
    expect(document).to_not be_valid
  end

  it "is valid with all attributes" do
    folder = Folder.new(name: 'Folder1', created_at: DateTime.now, updated_at: DateTime.now)
    folder.save!

    document = Document.new(
      name: 'Doc1',
      content: fixture_file_upload("#{Rails.root}/spec/fixtures/dummy.txt", 'text/xml'),
      folder_id: folder.id,
      created_at: DateTime.now,
      updated_at: DateTime.now
    )
    document.save!

    expect(document.content).to_not eq(nil)
    expect(document).to be_valid
  end

  it "is valid with all attributes in a subfolder" do
    folder = Folder.new(name: 'Folder1', created_at: DateTime.now, updated_at: DateTime.now)
    folder.save!

    subfolder = Folder.new(name: 'Folder1', main_folder_id: folder.id, created_at: DateTime.now, updated_at: DateTime.now)
    subfolder.save!

    document = Document.new(
      name: 'Doc1',
      content: fixture_file_upload("#{Rails.root}/spec/fixtures/dummy.txt", 'text/xml'),
      folder_id: subfolder.id,
      created_at: DateTime.now,
      updated_at: DateTime.now
    )
    document.save!

    expect(folder).to be_valid
    expect(subfolder).to be_valid
    expect(document.content).to_not eq(nil)
    expect(document).to be_valid
  end
end
