require "test_helper"

class DocumentTest < ActiveSupport::TestCase
  include ActionDispatch::TestProcess::FixtureFile

  test 'fail to save document without folder' do
    file_content = fixture_file_upload('1.megabyte', nil, :binary)
    document = Document.new(name: 'mydoc', storage_method: StorageMethods::Blob.name)
    assert_not(document.upload(file_content), 'The document should not be uploaded')
  end

  test 'fail to save document without name' do
    file_content = fixture_file_upload('1.megabyte', nil, :binary)
    document = Document.new(storage_method: StorageMethods::Blob.name, folder: Folder.path('test/folder'))
    assert_not(document.upload(file_content), 'The document should not be uploaded')
  end

  test 'fail to save document with blank name' do
    file_content = fixture_file_upload('1.megabyte', nil, :binary)
    document = Document.new(name: '', storage_method: StorageMethods::Blob.name, folder: Folder.path('test/folder'))
    assert_not(document.upload(file_content), 'The document should not be uploaded')
  end

  test 'fail to save document without storage_method' do
    file_content = fixture_file_upload('1.megabyte', nil, :binary)
    document = Document.new(name: 'mydoc', folder: Folder.path('test/folder'))
    assert_not(document.upload(file_content), 'The document should not be uploaded')
  end

  test 'fail to save document with blank storage_method' do
    file_content = fixture_file_upload('1.megabyte', nil, :binary)
    document = Document.new(name: 'mydoc', storage_method: '', folder: Folder.path('test/folder'))
    assert_not(document.upload(file_content), 'The document should not be uploaded')
  end

  test 'fail to save document without file' do
    file_content = nil
    document = Document.new(name: 'mydoc', storage_method: StorageMethods::Blob.name, folder: Folder.path('test/folder'))
    assert_not(document.upload(file_content), 'The document should not be uploaded')
  end

  test 'save document of 1 megabyte stored in database on blob format and deleted after' do
    file_content = fixture_file_upload('1.megabyte', nil, :binary)
    document = Document.new(name: 'mydoc', storage_method: StorageMethods::Blob.name, folder: Folder.path('test/folder'))
    assert(document.upload(file_content), 'Document should be uploaded')
    assert(document.persisted?, 'Document should be persisted')

    uploaded_document = Document.find(document.id)
    assert_equal(1.megabyte, File.size(uploaded_document.download), 'The file size returned should have 1 megabyte')

    key = uploaded_document.key
    stored_file = StorageMethods::Blob.new.download(key)
    assert_equal(1.megabyte, File.size(stored_file), 'The file size returned should have 1 megabyte')
    assert(uploaded_document.destroy, 'The document should be deleted')
    deleted_file = StorageMethods::Blob.new.download(key)
    assert_nil(deleted_file, 'The file should not exist anymore and must be returned nil')
  end

  test 'save document of 1 megabyte stored in hard drive and deleted after' do
    file_content = fixture_file_upload('1.megabyte', nil, :binary)
    document = Document.new(name: 'mydoc', storage_method: StorageMethods::HardDrive.name, folder: Folder.path('test/folder'))
    assert(document.upload(file_content), 'Document should be uploaded')
    assert(document.persisted?, 'Document should be persisted')

    uploaded_document = Document.find(document.id)
    assert_equal(1.megabyte, File.size(uploaded_document.download), 'The file size returned should have 1 megabyte')

    key = uploaded_document.key
    stored_file = StorageMethods::HardDrive.new.download(key)
    assert_equal(1.megabyte, File.size(stored_file), 'The file size returned should have 1 megabyte')
    assert(uploaded_document.destroy, 'The document should be deleted')
    deleted_file = StorageMethods::HardDrive.new.download(key)
    assert_nil(deleted_file, 'The file should not exist anymore and must be returned nil')
  end

  test 'successfully save first document and fail to save the second document with the equal folder and name' do
    first_file_content = fixture_file_upload('1.megabyte', nil, :binary)
    first_document = Document.new(name: 'mydoc', storage_method: StorageMethods::Blob.name, folder: Folder.path('test/folder'))
    assert(first_document.upload(first_file_content), 'The first document should be uploaded')
    assert(first_document.persisted?, 'The first document should be persisted')

    uploaded_document = Document.find(first_document.id)
    assert_equal(1.megabyte, File.size(uploaded_document.download), 'The file size returned should have 1 megabyte')

    second_file_content = fixture_file_upload('512.kilobytes', nil, :binary)
    second_document = Document.new(name: 'mydoc', storage_method: StorageMethods::Blob.name, folder: Folder.path('test/folder'))
    assert_not(second_document.upload(second_file_content), 'The second document should not be saved')
    
    second_document_file = StorageMethods::Blob.new.download(second_document.key)
    assert_nil(second_document_file, 'The file should not exist and must be returned nil')
  end

  test 'successfully save two documents with the equal name and different folders' do
    first_file_content = fixture_file_upload('1.megabyte', nil, :binary)
    first_document = Document.new(name: 'mydoc', storage_method: StorageMethods::Blob.name, folder: Folder.path('test/folder'))
    assert(first_document.upload(first_file_content), 'The first document should be uploaded')
    assert(first_document.persisted?, 'The first document should be persisted')

    uploaded_first_document = Document.find(first_document.id)
    assert_equal(1.megabyte, File.size(uploaded_first_document.download), 'The file size returned should have 1 megabyte')

    second_file_content = fixture_file_upload('512.kilobytes', nil, :binary)
    second_document = Document.new(name: 'mydoc', storage_method: StorageMethods::Blob.name, folder: Folder.path('folder/test'))
    assert(second_document.upload(second_file_content), 'The second document should be uploaded')
    assert(second_document.persisted?, 'The second document should be persisted')

    uploaded_second_document = Document.find(second_document.id)
    assert_equal(512.kilobytes, File.size(uploaded_second_document.download), 'The file size returned should have 512 kilobytes')

    assert(uploaded_first_document.destroy, 'The first document should be deleted')
    assert(uploaded_second_document.destroy, 'The second document should be deleted')
  end
end
